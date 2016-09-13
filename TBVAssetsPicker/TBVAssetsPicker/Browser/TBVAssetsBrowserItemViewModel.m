//
//  TBVAssetsBrowserItemViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsBrowserItemViewModel.h"
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsPickerTypes.h"

@implementation TBVAssetsBrowserItemViewModel
- (instancetype)initWithAsset:(TBVAsset *)asset
                       picker:(TBVAssetsPickerManager *__weak)picker {
    if (self = [super initWithAsset:asset picker:picker]) {
        self.targetSize = CGSizeMake(BQAP_SCREEN_WIDTH * kBQBrowserImageScaleForScreenBounds,
                                     BQAP_SCREEN_HEIGHT * kBQBrowserImageScaleForScreenBounds);
        /* 这里Fill会让图片更清晰 */
        self.contentImageSignal = [picker requestImageForAsset:asset
                                                    targetSize:self.targetSize
                                                   contentMode:TBVAssetsContentModeFill];
    }
    
    return self;
}
@end
