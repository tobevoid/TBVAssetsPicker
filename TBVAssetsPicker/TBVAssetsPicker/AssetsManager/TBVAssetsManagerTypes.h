//
//  TBVAssetsTypes.h
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#ifndef TBVAssetsManagerTypes_h
#define TBVAssetsManagerTypes_h
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TBVAssetsMediaType) {
    TBVAssetsMediaTypeImage = 0,
    TBVAssetsMediaTypeVideo,
    TBVAssetsMediaTypeAll,
};

typedef NS_ENUM(NSInteger, TBVAssetsDefinitionType) {
    TBVAssetsDefinitionTypeThumbnail = 0,
    TBVAssetsDefinitionTypeFullScreen,
    TBVAssetsDefinitionTypeFullResolution,
};

typedef NS_ENUM(NSInteger, TBVAssetsAuthorizationStatus) {
    TBVAssetsAuthorizationStatusNotDetermined = 0,
    TBVAssetsAuthorizationStatusRestricted,
    TBVAssetsAuthorizationStatusDenied,
    TBVAssetsAuthorizationStatusAuthorized,
};
CF_EXPORT const NSDictionary *TBVAssetsAuthorizationStatusStringsMap;

//ContentMode
// PH PHContentMode
// AL aspectRatioThumbnail thumbnail
typedef NS_ENUM(NSInteger, TBVAssetsContentMode) {
    TBVAssetsContentModeFit = 0,
    TBVAssetsContentModeFill,
};

/* constaint */
CF_EXPORT const CGFloat     kTBVPosterImageWidth;
CF_EXPORT const CGFloat     kTBVPosterImageHeight;

/* notification */
CF_EXPORT NSString * const  TBVAssetsAssetsDidChangeNotification;

#define TBV_SCREEN_SCALE   [UIScreen mainScreen].scale
#define TBV_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define TBV_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#endif /* TBVAssetsManagerTypes_h */
