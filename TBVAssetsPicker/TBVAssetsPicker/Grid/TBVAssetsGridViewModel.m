//
//  TBVAssetsGridViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsGridViewModel.h"
#import "TBVAssetsGridItemViewModel.h"
#import "TBVAssetsPickerTypes.h"
#import "TBVCollection.h"

@interface TBVAssetsGridViewModel()
//@property (strong, nonatomic) RACCommand *didSelectCommand;
@end

@implementation TBVAssetsGridViewModel
- (instancetype)initWithCollection:(TBVCollection *)collection
                            picker:(__weak TBVAssetsPickerManager *)picker
                         mediaType:(TBVAssetsMediaType)mediaType {
    if (self = [self init]) {
        self.collection = collection;
        
        @weakify(self)
        
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[picker requestAssetsForCollection:collection mediaType:mediaType]
                filter:^BOOL(NSArray *value) {
                    return value.count > 0;
                }]
                map:^id(NSArray *value) {
                    @strongify(self)
                    self.assets = value;
                    
                    return [value.rac_sequence
                            map:^id(TBVAsset *value) {
                                TBVAssetsGridItemViewModel *viewModel = [[TBVAssetsGridItemViewModel alloc]
                                                                         initWithAsset:value
                                                                         picker:picker];
                                return viewModel;
                            }].array;
                }];
        }];
        
        RAC(self, dataSource) = [self.requestDataCommand executionSignals].switchToLatest;
        [self.requestDataCommand execute:nil];
        
        self.dataSourceChangeSignal = [self.dataSourceChangeSignal doNext:^(NSArray *dataSource) {
            @strongify(self)
            for (TBVAssetsItemViewModel *viewModel in dataSource) {
                viewModel.didSelectCommand = self.didSelectCommand;
            }
        }];
        
        self.willBackFromBrowserCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id selectedAssets) {
            @strongify(self)
            /* tool bar */
            self.selectedAssets = selectedAssets;
            
            /* gird cell */
            for (TBVAssetsItemViewModel *viewModel in self.dataSource) {
                viewModel.selectedIndex = [self.selectedAssets indexOfObject:viewModel.asset];
            }

            return [RACSignal return:selectedAssets];
        }];
    }
    return self;
}

- (RACSignal *)dataSourceSignalWithCollection:(TBVCollection *)collection
                                       picker:(__weak TBVAssetsPickerManager *)picker
                                    mediaType:(TBVAssetsMediaType)mediaType {
    @weakify(self)
    return [[[picker requestAssetsForCollection:collection mediaType:mediaType]
        filter:^BOOL(NSArray *value) {
            return value.count > 0;
        }]
        map:^id(NSArray *value) {
            @strongify(self)
            self.assets = value;
            
            return [value.rac_sequence
                map:^id(TBVAsset *value) {
                    TBVAssetsGridItemViewModel *viewModel = [[TBVAssetsGridItemViewModel alloc]
                                                             initWithAsset:value
                                                             picker:picker];
                    return viewModel;
                }].array;
        }];
}

- (NSString *)title {
    return [self.collection collectionTitle];
}

- (NSString *)backTitle {
    return @" ";
}

- (NSString *)cancelTitle {
    return @"取消";
}
@end
