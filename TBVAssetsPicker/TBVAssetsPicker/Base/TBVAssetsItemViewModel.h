//
//  TBVAssetselectedItemViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/29/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class TBVAsset;
@class TBVAssetsPickerManager;

@interface TBVAssetsItemViewModel : NSObject
@property (strong, nonatomic) TBVAsset *asset;
@property (assign, nonatomic) CGSize targetSize;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) RACCommand *didSelectCommand;
@property (strong, nonatomic) RACSignal *contentImageSignal;

- (instancetype)initWithAsset:(TBVAsset *)asset
                       picker:(TBVAssetsPickerManager *__weak)picker;
@end
