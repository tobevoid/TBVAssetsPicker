//
//  TBVAssetsGridViewCell.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVAssetsGridItemViewModel;
@interface TBVAssetsGridViewCell : UICollectionViewCell
- (void)bindViewModel:(TBVAssetsGridItemViewModel *)viewModel;
@end
