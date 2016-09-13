//
//  TBVAssetsConfiguration.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 9/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBVAssetsPickerTypes.h"

@class TBVAsset;
@interface TBVAssetsConfiguration : NSObject
+ (instancetype)defaultConfiguration;
@property (nonatomic, strong) NSArray <TBVAsset *> *selectedAssets;
@property (assign, nonatomic) NSInteger maxSelectedCount;
@property (assign, nonatomic) BOOL showsEmptyAlbums;
@property (assign, nonatomic) TBVAssetsPickerMediaType mediaType;
@property (assign, nonatomic) BOOL shouldScrollToBottom;
@end
