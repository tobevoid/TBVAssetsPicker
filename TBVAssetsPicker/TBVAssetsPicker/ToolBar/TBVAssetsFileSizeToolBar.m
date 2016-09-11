//
//  TBVAssetsFileSizeToolBar.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsFileSizeToolBar.h"
#import "TBVAssetsSendToolBar.h"
#import "TBVAssetsToolBarViewModel.h"

@interface TBVAssetsFileSizeToolBar()
@property (strong, nonatomic) TBVAssetsSendToolBar *sendToolBar;
@property (strong, nonatomic) UILabel   *fileSizeLabel;
@end

@implementation TBVAssetsFileSizeToolBar
#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sendToolBar];
        [self addSubview:self.fileSizeLabel];
        [self layoutPageSubviews];
        RAC(self, fileSizeLabel.text) =
            [RACObserve(self.sendToolBar, viewModel.fileSizeStringSignal) switchToLatest];
    }
    return self;
}

- (void)layoutPageSubviews {
    [self.fileSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@200);
    }];
    [self.sendToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark public method
- (void)bindViewModel:(TBVAssetsToolBarViewModel *)viewModel {
    [self.sendToolBar bindViewModel:viewModel];
}

#pragma mark getter setter
- (UILabel *)fileSizeLabel
{
    if (_fileSizeLabel == nil) {
        _fileSizeLabel = [[UILabel alloc] init];
        _fileSizeLabel.font = [UIFont systemFontOfSize:14.0];
        _fileSizeLabel.textColor = [UIColor lightGrayColor];
        _fileSizeLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _fileSizeLabel;
}

- (TBVAssetsSendToolBar *)sendToolBar
{
    if (_sendToolBar == nil) {
        _sendToolBar = [[TBVAssetsSendToolBar alloc] init];
    }
    
    return _sendToolBar;
}
@end
