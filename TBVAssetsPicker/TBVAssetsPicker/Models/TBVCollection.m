//
//  BQAlbum.m
//  PhotoLibTest
//
//  Created by tripleCC on 15/12/10.
//  Copyright © 2015年 tripleCC. All rights reserved.
//

#import "TBVCollection.h"

@interface TBVCollection()
@property (assign, nonatomic) NSInteger assetCount;
@property (copy, nonatomic) NSString *title;
@end

@implementation TBVCollection
+ (instancetype)collectionWithOriginCollection:(NSObject *)aCollection {
    TBVCollection *collection = [[self alloc] init];
    if (collection) {
        collection.collection = aCollection;
    }
    return collection;
}

@end

