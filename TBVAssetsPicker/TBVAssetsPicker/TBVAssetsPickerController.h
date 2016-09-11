//
//  TBVAssetsPickerController.h
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TBVAsset.h"
#import "TBVAssetsPickerTypes.h"

@class TBVAsset;
@class TBVAssetsPickerManager;
@class TBVAssetsPickerController;
@protocol TBVAssetsPickerControllerDataSource <NSObject>
@optional
- (UINavigationController *)assetsPickerController:(TBVAssetsPickerController *)picker
         navigationControllerForRootViewController:(UIViewController *)rootViewController;
- (UIViewController *)viewControllerForAccessDenied:(TBVAssetsPickerController *)picker;
- (UICollectionViewLayout *)collectionViewLayout:(TBVAssetsPickerController *)picker;
@end

@protocol TBVAssetsPickerControllerDelegate <NSObject>
- (void)assetsPickerController:(TBVAssetsPickerController *)picker
         overMaxSelectedCount:(NSInteger)selectedCount;

- (void)assetsPickerController:(TBVAssetsPickerController *)picker
        didFinishPickingAssets:(NSArray<TBVAsset *> *)assets;

@optional
- (void)assetsPickerControllerDidCancel:(TBVAssetsPickerController *)picker;
@end

@interface TBVAssetsPickerController : UIViewController
@property (weak, nonatomic) id<TBVAssetsPickerControllerDelegate> delegate;
@property (weak, nonatomic) id<TBVAssetsPickerControllerDataSource> dataSource;
@property (nonatomic, strong) NSArray <TBVAsset *> *selectedAssets;
@property (assign, nonatomic) NSInteger maxSelectedCount;
@property (assign, nonatomic) BOOL showsEmptyAlbums;
@property (assign, nonatomic) TBVAssetsPickerMediaType mediaType;
@property (assign, nonatomic) BOOL shouldScrollToBottom;
@property (strong, nonatomic) TBVAssetsPickerManager *pickerManager;
@end
