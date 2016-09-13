//
//  TBVAssetsCollectionViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
@class TBVAssetsConfiguration;
@class TBVAssetsPickerManager;
@class TBVAssetsPickerController;
@interface TBVAssetsCollectionViewModel : NSObject
- (instancetype)initWithPicker:(__weak TBVAssetsPickerManager *)picker
                 configuration:(TBVAssetsConfiguration *)configuration;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) RACCommand *requestDataCommand;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *backTitle;
@property (strong, nonatomic, readonly) NSString *cancelTitle;
@end
