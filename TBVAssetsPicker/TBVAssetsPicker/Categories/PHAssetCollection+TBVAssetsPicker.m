//
//  PHAssetCollection+TBVAssetsPicker.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "PHAssetCollection+TBVAssetsPicker.h"

@implementation PHAssetCollection (TBVAssetsPicker)
- (NSUInteger)tbv_countOfAssetsFetchedWithOptions:(PHFetchOptions *)fetchOptions {
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:self options:fetchOptions];
    return result.count;
}
@end
