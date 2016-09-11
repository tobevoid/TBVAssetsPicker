//
//  TBVAssetsBrowserViewCell.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVAssetsBrowserItemViewModel;
@interface TBVAssetsBrowserViewCell : UICollectionViewCell
- (void)bindViewModel:(TBVAssetsBrowserItemViewModel *)viewModel;
@end
