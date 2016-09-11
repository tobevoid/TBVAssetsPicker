//
//  TBVAssetsGridViewController.h
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVAssetsGridViewModel, TBVAssetsPickerController;
@interface TBVAssetsGridViewController : UICollectionViewController
- (instancetype)initWithViewModel:(TBVAssetsGridViewModel *)viewModel
                           picker:(TBVAssetsPickerController *)picker;
@end
