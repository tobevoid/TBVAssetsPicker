//
//  ViewController.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 9/11/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "ViewController.h"
#import "TBVAssetsPickerController.h"

@interface ViewController () <TBVAssetsPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TBVAssetsPickerController *vc = [[TBVAssetsPickerController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

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

@end
