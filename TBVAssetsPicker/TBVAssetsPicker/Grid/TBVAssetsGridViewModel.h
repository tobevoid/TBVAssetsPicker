//
//  TBVAssetsGridViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBVAssetsViewModel.h"

@class TBVCollection;
@class TBVAssetsPickerManager;
@class TBVAssetsToolBarViewModel;

@interface TBVAssetsGridViewModel : TBVAssetsViewModel
@property (strong, nonatomic) RACCommand *willBackFromBrowserCommand;
@property (strong, nonatomic) TBVCollection *collection;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *backTitle;
@property (strong, nonatomic, readonly) NSString *cancelTitle;
- (instancetype)initWithCollection:(TBVCollection *)collection
                            picker:(__weak TBVAssetsPickerManager *)picker
                         mediaType:(TBVAssetsPickerMediaType)mediaType;
@end
