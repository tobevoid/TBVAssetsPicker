//
//  TBVAssetCollectionViewModel.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsCollectionItemViewModel.h"
#import "TBVAssetsPickerManager.h"
#import "TBVCollection.h"

@interface TBVAssetsCollectionItemViewModel()
@property (strong, nonatomic) RACSignal *posterImageSignal;
@property (strong, nonatomic) NSString *title;
@end

@implementation TBVAssetsCollectionItemViewModel
- (instancetype)initWithCollection:(TBVCollection *)collection
                            picker:(__weak TBVAssetsPickerManager *)picker
                         mediaType:(TBVAssetsPickerMediaType)mediaType {
    if (self = [self init]) {
        self.collection = collection;
        
        self.posterImageSignal = [picker requestPosterImageForCollection:collection
                                                               mediaType:mediaType];
        self.title = [NSString stringWithFormat:@"%@ (%@)",
                      collection.collectionTitle,
                      @([collection collectionAccurateAssetCountWithMediaType:mediaType])];
    }
    return self;
}
@end
