//
//  TBVAssetsPickerAccessDeniedViewController.m
//  PhotoBrowser
//
//  Created by tripleCC on 8/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsPickerAccessDeniedViewController.h"

@interface TBVAssetsPickerAccessDeniedViewController ()
@property (strong, nonatomic) UILabel *deniedTitleLabel;
@property (strong, nonatomic) UILabel *deniedTipLabel;
@end

@implementation TBVAssetsPickerAccessDeniedViewController
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.title = @"照片";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dismiss)];
    [self.view addSubview:self.deniedTitleLabel];
    [self.view addSubview:self.deniedTipLabel];
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    [self.deniedTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(100);
    }];
    [self.deniedTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deniedTitleLabel.mas_bottom).offset(5);
        make.centerX.width.equalTo(self.deniedTitleLabel);
    }];
}

#pragma mark event response
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter setter
- (UILabel *)deniedTitleLabel
{
    if (_deniedTitleLabel == nil) {
        _deniedTitleLabel = [[UILabel alloc] init];
        _deniedTitleLabel.font = [UIFont systemFontOfSize:16.0];
        _deniedTitleLabel.numberOfLines = 0;
        _deniedTitleLabel.textAlignment = NSTextAlignmentCenter;
        _deniedTitleLabel.textColor = [UIColor grayColor];
        _deniedTitleLabel.text = @"此应用程序没有权限访问您的照片或视频";
    }
    
    return _deniedTitleLabel;
}

- (UILabel *)deniedTipLabel
{
    if (_deniedTipLabel == nil) {
        _deniedTipLabel = [[UILabel alloc] init];
        _deniedTipLabel.font = [UIFont systemFontOfSize:14.0];
        _deniedTipLabel.numberOfLines = 0;
        _deniedTipLabel.textAlignment = NSTextAlignmentCenter;
        _deniedTipLabel.textColor = [UIColor lightGrayColor];
        _deniedTipLabel.text = @"在\"设置-隐私-图片\"中开启后即可查看";
        [_deniedTipLabel sizeToFit];
    }
    
    return _deniedTipLabel;
}
@end
