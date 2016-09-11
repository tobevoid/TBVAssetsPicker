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
typedef NS_ENUM(NSInteger, TBVAssetsPickerMediaType) {
    TBVAssetsPickerMediaTypeImage = 0,
    TBVAssetsPickerMediaTypeVideo,
    TBVAssetsPickerMediaTypeAll,
};

typedef NS_ENUM(NSInteger, TBVAssetsPickerDefinitionType) {
    TBVAssetsPickerDefinitionTypeThumbnail = 0,
    TBVAssetsPickerDefinitionTypeFullScreen,
    TBVAssetsPickerDefinitionTypeFullResolution,
};

typedef NS_ENUM(NSInteger, BQAuthorizationStatus) {
    BQAuthorizationStatusNotDetermined = 0,
    BQAuthorizationStatusRestricted,
    BQAuthorizationStatusDenied,
    BQAuthorizationStatusAuthorized,
};
CF_EXPORT const NSDictionary *BQAuthorizationStatusStringsMap;

//ContentMode
// PH PHContentMode
// AL aspectRatioThumbnail thumbnail
typedef NS_ENUM(NSInteger, TBVAssetsPickerContentMode) {
    TBVAssetsPickerContentModeFit = 0,
    TBVAssetsPickerContentModeFill,
};

CF_EXPORT NSString * const  kBQAssertsPickerMediaTypeKey;
/* constaint */
CF_EXPORT const CGFloat     kBQPosterImageWidth;
CF_EXPORT const CGFloat     kBQPosterImageHeight;
CF_EXPORT const CGFloat     kTBVAssetsPickerToolBarHeight;

CF_EXPORT const CGFloat     kBQBrowserImageScaleForScreenBounds;

/* notification */
CF_EXPORT NSString * const  TBVAssetsPickerAssetsDidChangeNotification;

#define BQAP_SCREEN_SCALE   [UIScreen mainScreen].scale
#define BQAP_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define BQAP_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#endif /* TBVAssetsPickerTypes_h */
