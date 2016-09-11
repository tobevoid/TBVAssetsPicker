//
//  TBVAssetsBrowserViewController.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/28/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsPickerController+PickerManager.h"
#import "UIViewController+TBVAssetsPicker.h"
#import "TBVAssetsPickerViewModelHelper.h"
#import "TBVAssetsBrowserViewController.h"
#import "TBVAssetsBrowserViewCell.h"
#import "TBVAssetsSendToolBar.h"
#import "TBVAssetsBrowserViewModel.h"
#import "TBVAssetsToolBarViewModel.h"
#import "TBVAssetsBrowserItemViewModel.h"
#import "TBVAssetsBrowserFlowLayout.h"
#import "TBVAssetsPickerTypes.h"

static NSString *const kTBVAssetsBrowserViewCellReuseIdentifier = @"kTBVAssetsBrowserViewCell";
@interface TBVAssetsBrowserViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) TBVAssetsBrowserViewModel *viewModel;
@property (strong, nonatomic) TBVAssetsSendToolBar *toolBar;
@property (strong, nonatomic) UIButton *selectedButton;
@end

@implementation TBVAssetsBrowserViewController
#pragma mark life cycle
- (instancetype)initWithViewModel:(TBVAssetsBrowserViewModel *)viewModel {
    TBVAssetsBrowserFlowLayout *layout = [[TBVAssetsBrowserFlowLayout alloc] init];
    if (self = [self initWithCollectionViewLayout:layout]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:self.selectedButton];
    [self setupCollectionView];
    [self.view addSubview:self.toolBar];
    [self layoutPageSubview];
    
    [self bindViewModel:nil];
}

- (void)bindViewModel:(id)viewModel {
    [TBVAssetsPickerViewModelHelper setupAssetsViewMode:self.viewModel
                                                picker:self.tbv_picker];
    
    @weakify(self)
    self.viewModel.clickImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
        self.toolBar.hidden = self.navigationController.navigationBar.hidden;
        return [RACSignal empty];
    }];
    
    [self.viewModel.dataSourceChangeSignal subscribeNext:^(id value) {
        @strongify(self)
        [self.collectionView reloadData];
        /* http://stackoverflow.com/questions/14977896/xcode-collectionviewcontroller-scrolltoitematindexpath-not-working */
        /* ios8+ can scroll to right position, ios8- can not without 'layoutIfNeeded' */
        [self.collectionView layoutIfNeeded];
        
        NSInteger currentIndex = [self.viewModel.assets indexOfObject:self.viewModel.currentAsset];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [self changeSelectedButtonForAsset:self.viewModel.currentAsset];
    }];
    
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

- (void)layoutPageSubview {
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(kTBVAssetPickerToolBarHeight));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /* disable pop gesture */
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self.viewModel willBackToGridCommand] execute:self.viewModel.selectedAssets];
    /* enable pop gesture */
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)dealloc {
    NSLog(@"%@ is being released", self);
}
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TBVAssetsBrowserViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTBVAssetsBrowserViewCellReuseIdentifier forIndexPath:indexPath];
    
    [cell bindViewModel:self.viewModel.dataSource[indexPath.item]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(nonnull UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    indexPath = [collectionView indexPathsForVisibleItems].firstObject;
    TBVAsset *asset = self.viewModel.assets[indexPath.item];
    [self changeSelectedButtonForAsset:asset];
}
#pragma mark event response

- (void)selectedButtonOnClicked:(UIButton *)sender {
    NSInteger currentIndex = [[self.collectionView indexPathsForVisibleItems].firstObject item];
    TBVAsset *asset = self.viewModel.assets[currentIndex];
    
    [[self.viewModel.dataSource[currentIndex] didSelectCommand] execute:asset];
    [self changeSelectedButtonForAsset:asset];
}

#pragma mark private method 
- (void)changeSelectedButtonForAsset:(TBVAsset *)asset {
    if ([self.viewModel.selectedAssets containsObject:asset]) {
        self.selectedButton.backgroundColor = [UIColor orangeColor];
        self.selectedButton.layer.borderWidth = 0;
    } else {
        self.selectedButton.backgroundColor = [UIColor clearColor];
        self.selectedButton.layer.borderWidth = 1;
    }
}

#pragma mark set up
- (void)setupCollectionView {
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[TBVAssetsBrowserViewCell class] forCellWithReuseIdentifier:kTBVAssetsBrowserViewCellReuseIdentifier];
    /* http://stackoverflow.com/questions/23596181/why-does-uicollectionview-log-an-error-when-the-cells-are-fullscreen */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* for image's spacing in browser */
    CGRect frame = self.collectionView.frame;
    frame.size.width += kTBVAssetsBrowserFlowLayoutMargin * 2;
    self.collectionView.frame = frame;
}

#pragma mark getter setter
- (UIButton *)selectedButton {
    if (_selectedButton == nil) {
        CGSize selectedButtonSize = CGSizeMake(20, 20);
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.bounds = CGRectMake(0, 0, selectedButtonSize.width, selectedButtonSize.height);
        _selectedButton.layer.cornerRadius = selectedButtonSize.width * 0.5;
        _selectedButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _selectedButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedButton setTitle:@"✓" forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(selectedButtonOnClicked:) forControlEvents:UIControlEventTouchDown];
    }
    return _selectedButton;
}

- (TBVAssetsSendToolBar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [[TBVAssetsSendToolBar alloc] init];
    }
    
    return _toolBar;
}
@end
