
//
//  TBVAssetsGridItemViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import "TBVAssetsPickerTypes.h"
#import "TBVAssetsGridItemViewModel.h"
#import "TBVAssetsPickerManager.h"

@implementation TBVAssetsGridItemViewModel
- (instancetype)initWithAsset:(TBVAsset *)asset
                       picker:(TBVAssetsPickerManager *__weak)picker {
    if (self = [super initWithAsset:asset picker:picker]) {
        self.contentImageSignal =
        [[[RACObserve(self, targetSize)
            distinctUntilChanged]
            map:^id(NSValue *value) {
                return [picker requestImageForAsset:asset
                                         targetSize:[value CGSizeValue]
                                        contentMode:TBVAssetsPickerContentModeFill];
            }]
            switchToLatest];
    }
    return self;
}
@end
