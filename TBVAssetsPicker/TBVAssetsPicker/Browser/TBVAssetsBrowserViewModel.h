//
//  TBVAssetsBrowserViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TBVAssetsViewModel.h"

@class TBVCollection;
@class TBVAssetsPickerManager;
@class TBVAssetsToolBarViewModel;

@interface TBVAssetsBrowserViewModel : TBVAssetsViewModel
@property (strong, nonatomic) RACCommand *willBackToGridCommand;
@property (strong, nonatomic) TBVAsset *currentAsset;
@property (strong, nonatomic) RACCommand *clickImageCommand;
- (instancetype)initWithAssets:(NSArray <TBVAsset *> *)assets
                        picker:(TBVAssetsPickerManager *__weak)picker;
@end
