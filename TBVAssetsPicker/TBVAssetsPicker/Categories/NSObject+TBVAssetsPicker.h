//
//  NSObject+BQExtesion.h
//  PhotoLibTest
//
//  Created by tripleCC on 15/12/14.
//  Copyright © 2015年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBVAssetsPickerTypes.h"

@interface NSObject (TBVAssetPicker)
// Asset
- (NSString *)tbv_assetLocalIdentifer;
- (CGSize)tbv_assetPixelSize;

// Collection
- (NSString *)tbv_collectionTitle;
- (NSInteger)tbv_collectionEstimatedAssetCount;
- (NSInteger)tbv_collectionAccurateAssetCountWithFetchOptions:(id)filterOptions;
- (NSInteger)tbv_collectionAccurateAssetCountWithMediaType:(TBVAssetsPickerMediaType)mediaType;
@end
