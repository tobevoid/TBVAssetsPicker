

//
//  TBVAssetsGridFlowLayout.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsGridFlowLayout.h"
#import "TBVAssetsPickerTypes.h"

static const CGFloat kBQDefaultFlowLayoutMargin = 3;
static const CGFloat kBQDefaultFlowLayoutColumn = 4;

@implementation TBVAssetsGridFlowLayout
- (instancetype)init {
    if (self = [super init]) {
        CGFloat totalMargin = kBQDefaultFlowLayoutMargin * (kBQDefaultFlowLayoutColumn + 1);
        CGFloat itemSizeHW = (BQAP_SCREEN_WIDTH - totalMargin) / kBQDefaultFlowLayoutColumn;
    
        self.itemSize = CGSizeMake(itemSizeHW, itemSizeHW);
        self.minimumLineSpacing = kBQDefaultFlowLayoutMargin;
        self.minimumInteritemSpacing = kBQDefaultFlowLayoutMargin;
        self.sectionInset = UIEdgeInsetsMake(kBQDefaultFlowLayoutMargin,
                                             kBQDefaultFlowLayoutMargin,
                                             kBQDefaultFlowLayoutMargin + kTBVAssetsPickerToolBarHeight,
                                             kBQDefaultFlowLayoutMargin);
    }
    return self;
}
@end
