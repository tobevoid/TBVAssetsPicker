//
//  TBVAssetsPickerTypes.h
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#ifndef TBVAssetsPickerTypes_h
#define TBVAssetsPickerTypes_h
#import <UIKit/UIKit.h>

CF_EXPORT NSString * const  kBQAssertsPickerMediaTypeKey;
/* constaint */
CF_EXPORT const CGFloat     kTBVAssetsPickerToolBarHeight;

CF_EXPORT const CGFloat     kBQBrowserImageScaleForScreenBounds;

#define BQAP_SCREEN_SCALE   [UIScreen mainScreen].scale
#define BQAP_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define BQAP_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#endif /* TBVAssetsPickerTypes_h */
