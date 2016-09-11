

//
//  TBVAssetBrowerFlowLayout.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/29/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsBrowserFlowLayout.h"
#import "TBVAssetsPickerTypes.h"

const CGFloat kTBVAssetsBrowserFlowLayoutMargin = 10;

@implementation TBVAssetsBrowserFlowLayout
- (instancetype)init {
    if (self = [super init]) {
        CGSize itemSize = CGSizeMake(BQAP_SCREEN_WIDTH, BQAP_SCREEN_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(itemSize.width + kTBVAssetsBrowserFlowLayoutMargin * 2,
                                   itemSize.height);
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
    }
    return self;
}
@end
