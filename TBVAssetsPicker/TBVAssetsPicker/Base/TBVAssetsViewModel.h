//
//  TBVAssetsViewModel.h
//  TBVAssetPickerController
//
//  Created by tripleCC on 9/9/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class TBVAsset;
@class TBVAssetsToolBarViewModel;

@interface TBVAssetsViewModel : NSObject
@property (strong, nonatomic) TBVAssetsToolBarViewModel *toolBarViewModel;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) RACSignal *dataSourceChangeSignal;
@property (strong, nonatomic) NSArray *assets;

@property (strong, nonatomic) NSMutableArray *selectedAssets;
@property (assign, nonatomic, readonly) NSInteger selectedAssetsCount;
@property (strong, nonatomic, readonly) RACSignal *selectedAssetsChangeSignal;

@property (assign, nonatomic) NSInteger maxSeletedCount;
@property (strong, nonatomic) RACCommand *didSelectCommand;

@property (strong, nonatomic) RACCommand *requestDataCommand;

- (void)addSelectedAsset:(TBVAsset *)asset;
- (void)removeSelectedAsset:(TBVAsset *)asset;
@end
