//
//  TBVAssetsGridViewController.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "UIViewController+TBVAssetsPicker.h"
#import "TBVAssetsPickerController+PickerManager.h"
#import "TBVAssetsPickerViewModelHelper.h"
#import "TBVAssetsPickerTypes.h"
#import "TBVAssetsGridFlowLayout.h"
#import "TBVAssetsGridViewController.h"
#import "TBVAssetsBrowserViewController.h"
#import "TBVAssetsFileSizeToolBar.h"
#import "TBVAssetsGridViewCell.h"
#import "TBVAssetsGridViewModel.h"
#import "TBVAssetsGridItemViewModel.h"
#import "TBVAssetsToolBarViewModel.h"
#import "TBVAssetsBrowserViewModel.h"

static NSString *const kTBVAssetsGridViewCellReuseIdentifier = @"kTBVAssetsGridViewCell";
@interface TBVAssetsGridViewController ()
@property (strong, nonatomic) TBVAssetsFileSizeToolBar *toolBar;
@property (strong, nonatomic) TBVAssetsGridViewModel *viewModel;
@end

@implementation TBVAssetsGridViewController
- (instancetype)initWithViewModel:(TBVAssetsGridViewModel *)viewModel
                           picker:(TBVAssetsPickerController *)picker {
    UICollectionViewLayout *layout = nil;
    if ([picker.dataSource respondsToSelector:@selector(collectionViewLayout:)]) {
        layout = [picker.dataSource collectionViewLayout:picker];
    }
    
    if (!layout) {
        layout = [[TBVAssetsGridFlowLayout alloc] init];
    }
    if (self = [self initWithCollectionViewLayout:layout]) {
        self.viewModel = viewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[TBVAssetsGridViewCell class]
            forCellWithReuseIdentifier:kTBVAssetsGridViewCellReuseIdentifier];
    self.navigationItem.title = self.viewModel.title;
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:self.viewModel.backTitle
                                     style:UIBarButtonItemStyleDone
                                    target:nil
                                    action:nil];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:self.viewModel.cancelTitle
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(dismiss)];
    [self.view addSubview:self.toolBar];
    [self layoutPageSubview];
    
    [self bindViewModel:nil];
}

- (void)bindViewModel:(id)viewModel {
    [TBVAssetsPickerViewModelHelper setupAssetsViewMode:self.viewModel
                                                picker:self.tbv_picker];
    
    @weakify(self)
    [self.viewModel.dataSourceChangeSignal subscribeNext:^(id value) {
        @strongify(self)
        [self.collectionView reloadData];
    }];
    
    if (self.tbv_picker.shouldScrollToBottom) {
        [[[[RACObserve(self, collectionView.contentSize)
            ignore:nil]
           filter:^BOOL(id value) {
               @strongify(self)
               return [value CGSizeValue].height > self.collectionView.frame.size.height;
           }]
          take:1]
         subscribeNext:^(id x) {
             @strongify(self)
             NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.viewModel.dataSource.count - 1 inSection:0];
             [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
         }];
    }
    
    [self.toolBar bindViewModel:self.viewModel.toolBarViewModel];
    
    [[[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:TBVAssetsPickerAssetsDidChangeNotification
        object:nil]
       takeUntil:self.rac_willDeallocSignal]
      distinctUntilChanged]
     subscribeNext:^(id x) {
         @strongify(self)
         /* refresh list */
     }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)layoutPageSubview {
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(kTBVAssetPickerToolBarHeight));
    }];
}

- (void)dealloc {
    NSLog(@"%@ is being released", self);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TBVAssetsGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTBVAssetsGridViewCellReuseIdentifier forIndexPath:indexPath];
    
    TBVAssetsGridItemViewModel *viewModel = self.viewModel.dataSource[indexPath.item];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout
                                                    layoutAttributesForItemAtIndexPath:indexPath];
    viewModel.targetSize = CGSizeMake(attributes.size.width * BQAP_SCREEN_SCALE,
                                      attributes.size.height * BQAP_SCREEN_SCALE);
    
    [cell bindViewModel:viewModel];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TBVAssetsBrowserViewModel *viewModel = [[TBVAssetsBrowserViewModel alloc]
                                          initWithAssets:self.viewModel.assets
                                          picker:self.tbv_picker.pickerManager];
    viewModel.selectedAssets = self.viewModel.selectedAssets;
    viewModel.currentAsset = self.viewModel.assets[indexPath.item];
    viewModel.willBackToGridCommand = self.viewModel.willBackFromBrowserCommand;
    TBVAssetsBrowserViewController *viewController = [[TBVAssetsBrowserViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark event response
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter setter
- (TBVAssetsFileSizeToolBar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [[TBVAssetsFileSizeToolBar alloc] init];
    }
    
    return _toolBar;
}
@end
