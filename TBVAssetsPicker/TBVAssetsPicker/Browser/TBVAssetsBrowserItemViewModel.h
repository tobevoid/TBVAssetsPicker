//
//  TBVAssetsBrowserItemViewModel.h
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBVAssetsItemViewModel.h"

@interface TBVAssetsBrowserItemViewModel : TBVAssetsItemViewModel
@property (strong, nonatomic) RACCommand *clickImageCommand;
@end
