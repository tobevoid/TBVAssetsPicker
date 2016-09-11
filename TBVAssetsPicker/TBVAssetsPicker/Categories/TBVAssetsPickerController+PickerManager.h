//
//  TBVAssetsPickerController+PickerManager.h
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TBVAssetsPickerController.h"
#import "TBVAssetsPickerManager.h"

@interface TBVAssetsPickerController (PickerManager)
@property (strong, nonatomic, readonly) TBVAssetsPickerManager *pickerManager;
@end
