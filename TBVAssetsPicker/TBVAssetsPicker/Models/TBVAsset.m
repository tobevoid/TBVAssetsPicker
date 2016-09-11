//
//  TBVAsset.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAsset.h"

@interface TBVAsset()
@property (copy, nonatomic) NSString *identifier;
@property (assign, nonatomic) CGSize pixelSize;
@end

@implementation TBVAsset
+ (instancetype)assetWithOriginAsset:(NSObject *)aAsset {
    TBVAsset *asset = [[self alloc] init];
    if (asset) {
        asset.asset         = aAsset;
    }
    return asset;
}
@end
