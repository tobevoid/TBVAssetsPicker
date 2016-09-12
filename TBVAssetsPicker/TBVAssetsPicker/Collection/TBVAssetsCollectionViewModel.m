//
//  TBVAssetsCollectionViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import "TBVAssetsPickerController+PickerManager.h"
#import "TBVAssetsCollectionViewModel.h"
#import "TBVAssetsCollectionItemViewModel.h"
#import "TBVCollection.h"

@implementation TBVAssetsCollectionViewModel
- (instancetype)initWithPicker:(TBVAssetsPickerController *__weak)picker {
    if (self = [self init]) {
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[picker.pickerManager requestAllCollections]
                filter:^BOOL(NSArray *value) {
                    return value.count > 0;
                }]
                map:^id(NSArray *value) {
                    RACSequence *dataSource = [value.rac_sequence map:^id(TBVCollection *value) {
                        return [[TBVAssetsCollectionItemViewModel alloc] initWithCollection:value
                                                                                     picker:picker];
                    }];
                    if (!picker.showsEmptyAlbums) {
                        dataSource = [dataSource filter:^BOOL(TBVAssetsCollectionItemViewModel *value) {
                            return [value.collection collectionAccurateAssetCountWithMediaType:picker.mediaType] > 0;
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
