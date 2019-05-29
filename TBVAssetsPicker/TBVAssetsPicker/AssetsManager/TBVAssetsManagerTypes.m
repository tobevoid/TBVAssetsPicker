//
//  TBVAssetsPickerTypes.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsManagerTypes.h"

const CGFloat kTBVPosterImageWidth = 70;
const CGFloat kTBVPosterImageHeight = kTBVPosterImageWidth;

NSString * const TBVAssetsAssetsDidChangeNotification = @"TBVAssetsAssetsDidChangeNotification";


const NSDictionary *TBVAssetsAuthorizationStatusStringsMap;

@interface TBVAssetsManagerTypes : NSObject

@end

@implementation TBVAssetsManagerTypes
+ (void)load {
    #define TBV_ASSETS_PICKER_TYPE_ELEMENT(key) @(key) : @#key
    
    TBVAssetsAuthorizationStatusStringsMap =
        @{TBV_ASSETS_PICKER_TYPE_ELEMENT(TBVAssetsAuthorizationStatusNotDetermined),
          TBV_ASSETS_PICKER_TYPE_ELEMENT(TBVAssetsAuthorizationStatusRestricted),
          TBV_ASSETS_PICKER_TYPE_ELEMENT(TBVAssetsAuthorizationStatusDenied),
          TBV_ASSETS_PICKER_TYPE_ELEMENT(TBVAssetsAuthorizationStatusAuthorized)};
}
@end
