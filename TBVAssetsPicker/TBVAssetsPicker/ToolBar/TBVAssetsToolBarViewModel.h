//
//  TBVAssetsToolBarViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@class TBVAsset;
@class TBVAssetsPickerManager;
@interface TBVAssetsToolBarViewModel : NSObject
@property (assign, nonatomic) NSInteger maxSeletedCount;
@property (assign, nonatomic) NSArray <TBVAsset *> *seletedAssets;
@property (strong, nonatomic) RACCommand *didSendCommand;

@property (strong, nonatomic, readonly) RACSignal *selectedStringSignal;
@property (strong, nonatomic, readonly) RACSignal *fileSizeStringSignal;
@property (strong, nonatomic, readonly) RACSignal *sendEnableSignal;

- (instancetype)initWithPicker:(TBVAssetsPickerManager *)picker;
@end
