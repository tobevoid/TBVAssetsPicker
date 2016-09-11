//
//  TBVAssetsBrowserViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsBrowserViewModel.h"
#import "TBVAssetsBrowserItemViewModel.h"
#import "TBVAsset.h"

@implementation TBVAssetsBrowserViewModel
- (instancetype)initWithAssets:(NSArray *)assets
                        picker:(TBVAssetsPickerManager *__weak)picker {
    if (self= [self init]) {
        self.assets = assets;
        
        @weakify(self)
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal return:[assets.rac_sequence map:^id(id asset) {
                return [[TBVAssetsBrowserItemViewModel alloc] initWithAsset:asset picker:picker];
            }].array];
        }];
        
        RAC(self, dataSource) = [[self.requestDataCommand executionSignals] switchToLatest];
        [self.requestDataCommand execute:nil];
        
        self.dataSourceChangeSignal = [[self.dataSourceChangeSignal
                                         combineLatestWith:RACObserve(self, clickImageCommand)] reduceEach:^id (NSArray *dataSource, RACCommand *clickImageCommand){
            @strongify(self)
            for (TBVAssetsBrowserItemViewModel *viewModel in dataSource) {
                viewModel.didSelectCommand = self.didSelectCommand;
                viewModel.clickImageCommand = clickImageCommand;
            }
            return dataSource;
        }];
    }
    return self;
}
@end
