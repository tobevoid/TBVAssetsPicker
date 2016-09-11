//
//  TBVAssetsBrowserViewController.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVAssetsBrowserViewModel;
@interface TBVAssetsBrowserViewController : UICollectionViewController
- (instancetype)initWithViewModel:(TBVAssetsBrowserViewModel *)viewModel;
@end
