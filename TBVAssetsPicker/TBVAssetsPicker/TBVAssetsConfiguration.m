//
//  TBVAssetsConfiguration.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 9/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsConfiguration.h"

@implementation TBVAssetsConfiguration
+ (instancetype)defaultConfiguration {
    TBVAssetsConfiguration *configuration = [[TBVAssetsConfiguration alloc] init];
    configuration.selectedAssets = nil;
    configuration.maxSelectedCount = 9;
    configuration.showsEmptyAlbums = NO;
    configuration.mediaType = TBVAssetsMediaTypeImage;
    configuration.shouldScrollToBottom = YES;
    return configuration;
}
@end
