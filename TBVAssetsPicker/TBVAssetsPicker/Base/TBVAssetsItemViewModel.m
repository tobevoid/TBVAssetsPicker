//
//  TBVAssetselectedItemViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/29/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsItemViewModel.h"

@implementation TBVAssetsItemViewModel
- (instancetype)initWithAsset:(TBVAsset *)asset
                       picker:(TBVAssetsPickerManager *__weak)picker {
    if (self = [self init]) {
        self.selectedIndex = NSNotFound;
        self.asset = asset;
    }
    return self;
}
@end
