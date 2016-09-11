//
//  TBVAssetsSendToolBar.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsSendToolBar.h"
#import "TBVAssetsToolBarViewModel.h"

@interface TBVAssetsSendToolBar()
@property (strong, nonatomic) UIButton  *sendButton;
@property (strong, nonatomic) UIView    *seperatorLineView;
@property (strong, nonatomic) TBVAssetsToolBarViewModel *viewModel;
@end

@implementation TBVAssetsSendToolBar
#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sendButton];
        [self addSubview:self.seperatorLineView];
        [self layoutPageSubviews];
        
        [self.sendButton rac_liftSelector:@selector(setTitle:forState:)
                              withSignals:[RACObserve(self, viewModel.selectedStringSignal) switchToLatest], [RACSignal return:@(UIControlStateNormal)], nil];
        
        RAC(self, sendButton.backgroundColor) = [RACSignal
            if:[RACObserve(self, viewModel.sendEnableSignal)
                switchToLatest]
            then:[RACSignal return:[UIColor orangeColor]]
            else:[RACSignal return:[UIColor lightGrayColor]]];
        
        RAC(self, sendButton.enabled) = [RACObserve(self, viewModel.sendEnableSignal) switchToLatest];
        
        @weakify(self)
        [[self.sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.viewModel.didSendCommand execute:self.viewModel.seletedAssets];
        }];
        
    }
    return self;
}

- (void)layoutPageSubviews {
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.equalTo(@90);
    }];
    
    [self.seperatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.left.right.equalTo(self);
    }];
}

#pragma mark public method
- (void)bindViewModel:(TBVAssetsToolBarViewModel *)viewModel {
    self.viewModel = viewModel;
}

#pragma mark getter setter
- (UIView *)seperatorLineView
{
    if (_seperatorLineView == nil) {
        _seperatorLineView = [[UIView alloc] init];
        _seperatorLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    
    return _seperatorLineView;
}

- (UIButton *)sendButton
{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = [UIColor lightGrayColor];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _sendButton.layer.cornerRadius = 5;
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _sendButton.enabled = NO;
    }
    
    return _sendButton;
}
@end
