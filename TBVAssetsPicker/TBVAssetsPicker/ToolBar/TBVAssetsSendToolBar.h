//
//  TBVAssetsSendToolBar.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBVAssetsToolBarViewModel;
@interface TBVAssetsSendToolBar : UIView
@property (strong, nonatomic, readonly) TBVAssetsToolBarViewModel *viewModel;
- (void)bindViewModel:(TBVAssetsToolBarViewModel *)viewModel;
@end
