//
//  TBVAssetCollectionViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsCollectionItemViewModel.h"
#import "TBVAssetsPickerController+PickerManager.h"
#import "NSObject+TBVAssetsPicker.h"
#import "TBVCollection.h"

@interface TBVAssetsCollectionItemViewModel()
@property (strong, nonatomic) RACSignal *posterImageSignal;
@property (strong, nonatomic) NSString *title;
@end

@implementation TBVAssetsCollectionItemViewModel
- (instancetype)initWithCollection:(TBVCollection *)collection
                            picker:(__weak TBVAssetsPickerController *)picker {
    if (self = [self init]) {
        self.collection = collection;
        
        self.posterImageSignal = [picker.pickerManager requestPosterImageForCollection:collection
                                                                             mediaType:picker.mediaType];
        self.title = [NSString stringWithFormat:@"%@ (%@)",
                      collection.collection.tbv_collectionTitle,
                      @([collection.collection tbv_collectionAccurateAssetCountWithMediaType:picker.mediaType])];
    }
    return self;
}
@end
