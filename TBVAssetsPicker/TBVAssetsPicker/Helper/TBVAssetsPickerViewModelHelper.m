
//
//  TBVAssetsPickerViewModelHelper.m
//  TPCAssetPickerController
//
//  Created by tripleCC on 9/9/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsPickerViewModelHelper.h"
#import "TBVAssetsPickerController+PickerManager.h"
#import "TBVAssetsToolBarViewModel.h"
#import "TBVAssetsViewModel.h"

@implementation TBVAssetsPickerViewModelHelper
+ (void)setupAssetsViewMode:(TBVAssetsViewModel *)viewModel
               picker:(TBVAssetsPickerController *)picker {
    viewModel.toolBarViewModel = [TBVAssetsPickerViewModelHelper
                                  toolBarViewModelWithPicker:picker
                                  selectedAssetsChangeSignal:viewModel.selectedAssetsChangeSignal];
    viewModel.maxSeletedCount = picker.maxSelectedCount;
    
    [[[viewModel.didSelectCommand
        executionSignals]
        switchToLatest]
        subscribeNext:^(id value) {
            if (!value && [picker.delegate respondsToSelector:@selector(assetsPickerController:overMaxSelectedCount:)]) {
                [picker.delegate assetsPickerController:picker
                                   overMaxSelectedCount:picker.maxSelectedCount];
            }
        }];
}

+ (TBVAssetsToolBarViewModel *)toolBarViewModelWithPicker:(TBVAssetsPickerController *)picker
                             selectedAssetsChangeSignal:(RACSignal *)changeSignal {
    TBVAssetsToolBarViewModel *toolBarViewModel = [[TBVAssetsToolBarViewModel alloc]
                                       initWithPicker:picker.pickerManager];
    toolBarViewModel.maxSeletedCount = picker.maxSelectedCount;
    [[[toolBarViewModel.didSendCommand
       executionSignals]
      switchToLatest]
     subscribeNext:^(id selectedAssets) {
         if ([picker.delegate respondsToSelector:@selector(assetsPickerController:didFinishPickingAssets:)]) {
             [picker.delegate assetsPickerController:picker
                              didFinishPickingAssets:selectedAssets];
         }
     }];
    RAC(toolBarViewModel, seletedAssets) = changeSignal;
    return toolBarViewModel;
}
@end
