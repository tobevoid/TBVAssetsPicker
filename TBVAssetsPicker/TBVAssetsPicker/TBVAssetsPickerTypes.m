//
//  TBVAssetsPickerTypes.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsPickerTypes.h"

const CGFloat kBQPosterImageWidth = 70;
const CGFloat kBQPosterImageHeight = kBQPosterImageWidth;
const CGFloat kTBVAssetsPickerToolBarHeight = 50;

const CGFloat kBQBrowserImageScaleForScreenBounds = 2;

NSString * const kBQAssertsPickerMediaTypeKey = @"kBQAssertsPickerMediaType";

NSString * const TBVAssetsPickerAssetsDidChangeNotification = @"TBVAssetsPickerAssetsDidChangeNotification";


const NSDictionary *BQAuthorizationStatusStringsMap;

@interface TBVAssetsPickerTypes : NSObject

@end

@implementation TBVAssetsPickerTypes
+ (void)load {
    #define BQ_ASSETS_PICKER_TYPE_ELEMENT(key) @(key) : @#key
    
    BQAuthorizationStatusStringsMap =
        @{BQ_ASSETS_PICKER_TYPE_ELEMENT(BQAuthorizationStatusNotDetermined),
          BQ_ASSETS_PICKER_TYPE_ELEMENT(BQAuthorizationStatusRestricted),
          BQ_ASSETS_PICKER_TYPE_ELEMENT(BQAuthorizationStatusDenied),
          BQ_ASSETS_PICKER_TYPE_ELEMENT(BQAuthorizationStatusAuthorized)};
}
@end