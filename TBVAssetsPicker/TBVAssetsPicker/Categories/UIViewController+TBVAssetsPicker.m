//
//  UIViewController+TBVAssetsPicker.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "UIViewController+TBVAssetsPicker.h"
@implementation UIViewController (TBVAssetsPicker)
- (TBVAssetsPickerController *)tbv_picker {
    return (TBVAssetsPickerController *)self.navigationController.parentViewController;
}
@end
