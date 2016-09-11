//
//  TBVAssetsPickerController.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsPickerController.h"
#import "TBVAssetsPickerManager+Authorization.h"
#import "TBVAssetsCollectionViewController.h"
#import "TBVAssetsPickerAccessDeniedViewController.h"
#import "TBVAssetsGridViewController.h"
#import "TBVAssetsPickerManager.h"
#import "TBVAssetsGridViewModel.h"

@interface TBVAssetsPickerController ()
@property (strong, nonatomic) TBVAssetsPickerManager *pickerManager;
@end

@implementation TBVAssetsPickerController
- (instancetype)init {
    if (self = [super init]) {
        _maxSelectedCount = 9;
        _shouldScrollToBottom = YES;
    }
    return self;
}

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:TBVAssetsPickerAssetsDidChangeNotification object:nil]
        takeUntil:self.rac_willDeallocSignal]
        subscribeNext:^(id x) {
            NSLog(@"assets did change: %@", x);
        }];
    
    @weakify(self)
    
    /* 如果应用在后台时，更改了权限，当切回前台后，App会重新启动 */
//    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        @strongify(self)
//        NSLog(@"authorization did change to: %@", BQAuthorizationStatusStringsMap[@([self.pickerManager authorizationStatus])]);
//        
//    }];
    
    [[self.pickerManager requestAuthorization] subscribeNext:^(NSNumber *granted) {
        @strongify(self)
        [self setupChildController];
        if ([self.pickerManager isAuthorized]) [self pushToGridViewController];
    }];
}

- (void)dealloc {
    NSLog(@"%@ is being released", self);
}

#pragma mark private method
- (void)setupChildController {
    if (self.childViewControllers.count) return;
    
    UIViewController *rootViewController = [self viewControllerToPresentation];
    UINavigationController *navigationController = [self navigationControllerWithRootViewController:rootViewController];
    [self addChildViewController:navigationController];
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    [navigationController didMoveToParentViewController:self];
}

- (void)pushToGridViewController {
    @weakify(self)
    [[self.pickerManager requestCameraRollCollection] subscribeNext:^(id collection) {
        @strongify(self)
        TBVAssetsGridViewModel *viewModel = [[TBVAssetsGridViewModel alloc]
                                            initWithCollection:collection
                                            picker:self.pickerManager
                                            mediaType:self.mediaType];
        TBVAssetsGridViewController *viewController = [[TBVAssetsGridViewController alloc]
                                                      initWithViewModel:viewModel
                                                      picker:self];
        [self.childViewControllers.firstObject pushViewController:viewController
                                                         animated:NO];
    }];
}

- (UIViewController *)viewControllerToPresentation {
    UIViewController *viewController = nil;
    
    if ([self.pickerManager isAuthorized]) {
        viewController = [[TBVAssetsCollectionViewController alloc] init];
    } else {
        if ([self.dataSource respondsToSelector:@selector(viewControllerForAccessDenied:)]) {
            viewController = [self.dataSource viewControllerForAccessDenied:self];
        }
        if (!viewController) {
            viewController = [[TBVAssetsPickerAccessDeniedViewController alloc] init];
        }
    }

    return viewController;
}

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController {
    UINavigationController *navigationController = nil;
    
    if ([self.dataSource respondsToSelector:@selector(assetsPickerController:navigationControllerForRootViewController:)]) {
        navigationController = [self.dataSource assetsPickerController:self navigationControllerForRootViewController:viewController];
    }
    if (!navigationController) {
        navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    
    return navigationController;
}

#pragma mark getter setter
- (TBVAssetsPickerManager *)pickerManager
{
    if (_pickerManager == nil) {
        _pickerManager = [TBVAssetsPickerManager manager];
    }
    
    return _pickerManager;
}
@end
