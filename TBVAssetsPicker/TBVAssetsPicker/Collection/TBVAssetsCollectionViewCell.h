//
//  TBVAssetsCollectionViewCell.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVCollection;
@class TBVAssetsCollectionItemViewModel;
@interface TBVAssetsCollectionViewCell : UITableViewCell
- (void)bindViewModel:(TBVAssetsCollectionItemViewModel *)viewModel;
@end
