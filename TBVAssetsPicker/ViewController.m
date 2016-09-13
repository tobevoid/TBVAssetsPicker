//
//  ViewController.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 9/11/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "ViewController.h"
#import "TBVAssetsPickerController.h"
#import "TBVLogger.h"
#import "TBVAssetsReformer.h"
#import "TBVAssetsConfiguration.h"

@interface ViewController () <TBVAssetsPickerControllerDelegate>
@property (strong, nonatomic) TBVAssetsReformer *reformer;
@end

@implementation ViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithTitle:@"相片" style:UIBarButtonItemStyleDone target:nil action:nil];
    @weakify(self)
    photoItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        TBVAssetsPickerController *viewController = [[TBVAssetsPickerController alloc] initWithPickManager:self.reformer.pickManager];
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
        
        return [RACSignal empty];
    }];
    self.navigationItem.rightBarButtonItem = photoItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.navigationItem.rightBarButtonItem.rac_command execute:nil];
    });
}

#pragma mark TBVAssetsPickerControllerDelegate

- (void)assetsPickerController:(TBVAssetsPickerController *)picker overMaxSelectedCount:(NSInteger)selectedCount {
    NSString *title = [NSString stringWithFormat:@"最多只能选择%@张", @(selectedCount)];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:nil
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)assetsPickerController:(TBVAssetsPickerController *)picker didFinishPickingAssets:(NSArray<TBVAsset *> *)assets {
    TBVLogDebug(@"selected assets %@", assets);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self sendAssets:assets];
}

#pragma mark private method
- (void)sendAssets:(NSArray <TBVAsset *> *)assets {
    RACSignal *concatedSignal = [[assets.rac_sequence
        map:^id(TBVAsset *asset) {
            return [[[[self.reformer imageWithAsset:asset mode:TBVAssetsReformerModeLarge]
                filter:^BOOL(RACTuple *value) {
                    return [value.second integerValue] == 0;
                }]
                reduceEach:^id (UIImage *image, NSNumber *degraded){
                    /* signal which sends image to server */
                    return [[RACSignal return:image] delay:1.0];
                }]
                switchToLatest];
        }]
        foldLeftWithStart:nil reduce:^id(RACSignal *accumulator, RACSignal *value) {
            return accumulator ? [accumulator concat:value] : value;
        }];
    
    [concatedSignal subscribeNext:^(id value) {
        TBVLogDebug(@"%@", value);
    }];
}

#pragma mark getter setter
- (TBVAssetsReformer *)reformer {
    if (_reformer == nil) {
        _reformer = [TBVAssetsReformer reformer];
    }
    
    return _reformer;
}

@end
