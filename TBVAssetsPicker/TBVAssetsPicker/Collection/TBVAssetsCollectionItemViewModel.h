//
//  TBVAssetCollectionViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TBVAssetsPickerTypes.h"
#import "TBVAssetsManagerTypes.h"

@class TBVCollection;
@class TBVAssetsPickerManager;
@class TBVAssetsPickerController;
@interface TBVAssetsCollectionItemViewModel : NSObject
- (instancetype)initWithCollection:(TBVCollection *)collection
                            picker:(__weak TBVAssetsPickerManager *)picker
                         mediaType:(TBVAssetsMediaType)mediaType;
@property (strong, nonatomic) TBVCollection *collection;
@property (strong, nonatomic, readonly) RACSignal *posterImageSignal;
@property (strong, nonatomic, readonly) NSString *title;
@end
