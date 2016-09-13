//
//  TBVAssetsCollectionViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import "TBVAssetsConfiguration.h"
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsCollectionViewModel.h"
#import "TBVAssetsCollectionItemViewModel.h"
#import "TBVCollection.h"

@implementation TBVAssetsCollectionViewModel
- (instancetype)initWithPicker:(__weak TBVAssetsPickerManager *)picker
                 configuration:(TBVAssetsConfiguration *)configuration {
    if (self = [self init]) {
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[picker requestAllCollections]
                filter:^BOOL(NSArray *value) {
                    return value.count > 0;
                }]
                map:^id(NSArray *value) {
                    RACSequence *dataSource = [value.rac_sequence map:^id(TBVCollection *value) {
                        return [[TBVAssetsCollectionItemViewModel alloc] initWithCollection:value picker:picker mediaType:configuration.mediaType];
                    }];
                    if (!configuration.showsEmptyAlbums) {
                        dataSource = [dataSource filter:^BOOL(TBVAssetsCollectionItemViewModel *value) {
                            return [value.collection collectionAccurateAssetCountWithMediaType:configuration.mediaType] > 0;
                        }];
                    }
                    return dataSource.array;
                }];
        }];
        RAC(self, dataSource) = [[self.requestDataCommand executionSignals] switchToLatest];
        [self.requestDataCommand execute:nil];
    }
    return self;
}

- (NSString *)title {
    return @"照片";
}

- (NSString *)backTitle {
    return @" ";
}

- (NSString *)cancelTitle {
    return @"取消";
}
@end
