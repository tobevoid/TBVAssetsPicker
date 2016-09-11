//
//  ViewController.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 9/11/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "ViewController.h"
#import "TBVAssetsPickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TBVAssetsPickerController *vc = [[TBVAssetsPickerController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
