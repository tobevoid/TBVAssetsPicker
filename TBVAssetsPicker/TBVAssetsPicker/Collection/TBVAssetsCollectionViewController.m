//
//  TBVAssetsCollectionViewController.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "UIViewController+TBVAssetsPicker.h"
#import "NSObject+TBVAssetsPicker.h"
#import "TBVAssetsPickerController+PickerManager.h"
#import "TBVAssetsPickerManager+Authorization.h"
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsCollectionViewController.h"
#import "TBVAssetsGridViewController.h"
#import "TBVAssetsCollectionViewCell.h"
#import "TBVCollection.h"
#import "TBVAssetsGridViewModel.h"
#import "TBVAssetsCollectionViewModel.h"
#import "TBVAssetsCollectionItemViewModel.h"

static const CGFloat kTBVAssetsCollectionViewCellHeight = 90.0f;
static NSString *const kTBVAssetsCollectionViewCellReuseIdentifier = @"kTBVAssetsCollectionViewCell";

@interface TBVAssetsCollectionViewController ()
@property (strong, nonatomic) TBVAssetsCollectionViewModel *viewModel;
@end

@implementation TBVAssetsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.viewModel.title;
    self.tableView.alwaysBounceVertical = YES;
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TBVAssetsCollectionViewCell class]
           forCellReuseIdentifier:kTBVAssetsCollectionViewCellReuseIdentifier];
    
    
    @weakify(self)
    [[RACObserve(self, viewModel.dataSource)
        filter:^BOOL(NSArray *value) {
            return value.count > 0;
        }]
        subscribeNext:^(NSArray *value) {
            @strongify(self)
            [self.tableView reloadData];
        }];
    
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

- (void)dealloc {
    NSLog(@"%@ is being released", self);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBVAssetsCollectionViewCell *cell = [tableView
                                       dequeueReusableCellWithIdentifier:kTBVAssetsCollectionViewCellReuseIdentifier
                                       forIndexPath:indexPath];
    
    [cell bindViewModel:self.viewModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTBVAssetsCollectionViewCellHeight;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TBVCollection *collection = [self.viewModel.dataSource[indexPath.row] collection];
    TBVAssetsGridViewModel *viewModel = [[TBVAssetsGridViewModel alloc]
                                        initWithCollection:collection
                                        picker:self.tbv_picker.pickerManager
                                        mediaType:self.tbv_picker.mediaType];
    TBVAssetsGridViewController *viewController = [[TBVAssetsGridViewController alloc]
                                                  initWithViewModel:viewModel
                                                  picker:self.tbv_picker];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark event response
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter setter
- (TBVAssetsCollectionViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[TBVAssetsCollectionViewModel alloc] initWithPicker:self.tbv_picker];;
    }
    
    return _viewModel;
}
@end
