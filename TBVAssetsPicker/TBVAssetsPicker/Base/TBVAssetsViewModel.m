//
//  TBVAssetsViewModel.m
//  TPCAssetPickerController
//
//  Created by tripleCC on 9/9/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsViewModel.h"
#import "TBVAssetsItemViewModel.h"

@interface TBVAssetsViewModel()
@property (assign, nonatomic) NSInteger selectedAssetsCount;
@property (strong, nonatomic) RACSignal *selectedAssetsChangeSignal;
@end

@implementation TBVAssetsViewModel
#pragma mark life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self)
        self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(TBVAsset *input) {
            @strongify(self)
            /* tool bar */
            if ([self.selectedAssets containsObject:input]) {
                [self removeSelectedAsset:input];
            } else {
                if (self.selectedAssets.count == self.maxSeletedCount) {
                    return [RACSignal return:nil];
                }
                [self addSelectedAsset:input];
            }
            
            /* for cell */
            for (TBVAssetsItemViewModel *viewModel in self.dataSource) {
                viewModel.selectedIndex = [self.selectedAssets indexOfObject:viewModel.asset];
            }
            
            return [RACSignal return:input];
        }];
        
        /* tool bar */
        self.selectedAssetsChangeSignal = [[RACObserve(self, selectedAssetsCount)
                                            merge:RACObserve(self, selectedAssets)]
                                           map:^id(id value) {
            @strongify(self)
            return self.selectedAssets;
        }];
        
        self.dataSourceChangeSignal = [[RACObserve(self, dataSource)
                                        ignore:nil]
                                       filter:^BOOL(id value) {
            return [value count] > 0;
        }];
    }
    return self;
}

#pragma mark public method
- (void)addSelectedAsset:(TBVAsset *)asset {
    NSCParameterAssert(asset);
    [self.selectedAssets addObject:asset];
    self.selectedAssetsCount = self.selectedAssets.count;
}

- (void)removeSelectedAsset:(TBVAsset *)asset {
    NSCParameterAssert(asset);
    [self.selectedAssets removeObject:asset];
    self.selectedAssetsCount = self.selectedAssets.count;
}

- (void)reloadData {
    
}
#pragma mark getter
- (NSMutableArray *)selectedAssets {
    if (_selectedAssets == nil) {
        _selectedAssets = [NSMutableArray array];
    }
    
    return _selectedAssets;
}
@end
