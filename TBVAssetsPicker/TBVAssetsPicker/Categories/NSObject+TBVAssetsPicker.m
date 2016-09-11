//
//  NSObject+BQExtesion.m
//  PhotoLibTest
//
//  Created by tripleCC on 15/12/14.
//  Copyright © 2015年 tripleCC. All rights reserved.
//

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSObject+TBVAssetsPicker.h"
#import "PHAssetCollection+TBVAssetsPicker.h"
#import "PHFetchOptions+TBVAssetsPicker.h"
#import "ALAssetsFilter+TBVAssetsPicker.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated"
@implementation NSObject (TBVAssetPicker)
- (NSString *)tbv_assetLocalIdentifer {
    if ([self class] != [ALAsset class]) {
        return ((PHAsset *)self).localIdentifier;
    } else {
        return ((ALAsset *)self).defaultRepresentation.url.absoluteString;
    }
}

- (CGSize)tbv_assetPixelSize {
    if ([self class] != [ALAsset class]) {
        PHAsset *asset = (PHAsset *)self;
        return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    } else {
        ALAsset *asset = (ALAsset *)self;
        return [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage].size;
    }
}

- (NSString *)tbv_collectionTitle {
    if ([self class] != [ALAssetsGroup class]) {
        return  ((PHAssetCollection *)self).localizedTitle;
    } else {
        return [(ALAssetsGroup *)self valueForProperty:ALAssetsGroupPropertyName];
    }
}

- (NSInteger)tbv_collectionEstimatedAssetCount {
    if ([self class] != [ALAssetsGroup class]) {
        return ((PHAssetCollection *)self).estimatedAssetCount;
    } else {
        return [(ALAssetsGroup *)self numberOfAssets];
    }
}

- (NSInteger)tbv_collectionAccurateAssetCountWithFetchOptions:(id)filterOptions {
    if ([self class] != [ALAssetsGroup class]) {
        PHAssetCollection *collection = (PHAssetCollection *)self;
        if ([filterOptions isKindOfClass:[PHFetchOptions class]]) {
            return [collection tbv_countOfAssetsFetchedWithOptions:filterOptions];
        }
    } else {
        ALAssetsGroup *group = (ALAssetsGroup *)self;
        if ([filterOptions isKindOfClass:[ALAssetsFilter class]]) {
            [group setAssetsFilter:filterOptions];
            return group.numberOfAssets;
        }
    }
    return 0;
}

- (NSInteger)tbv_collectionAccurateAssetCountWithMediaType:(TBVAssetsPickerMediaType)mediaType {
    NSObject *filterOptions = nil;
    if ([self class] != [ALAssetsGroup class]) {
        filterOptions = [PHFetchOptions tbv_fetchOptionsWithCustomMediaType:mediaType];
    } else {
        filterOptions = [ALAssetsFilter tbv_assetsFilterWithCustomMediaType:mediaType];
    }
    return [self tbv_collectionAccurateAssetCountWithFetchOptions:filterOptions];
}
@end
#pragma clang diagnostic pop