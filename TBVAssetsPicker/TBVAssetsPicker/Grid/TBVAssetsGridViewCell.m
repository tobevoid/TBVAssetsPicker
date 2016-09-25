//
//  TBVAssetsGridViewCell.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/26/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsPickerTypes.h"
#import "TBVAssetsGridViewCell.h"
#import "TBVAssetsPickerSelectButton.h"
#import "TBVAssetsGridItemViewModel.h"

@interface TBVAssetsGridViewCell()
@property (strong, nonatomic) TBVAssetsPickerSelectButton *selectedButton;
@property (strong, nonatomic) UIImageView *contentImageView;
@property (strong, nonatomic) TBVAssetsGridItemViewModel *viewModel;
@end

@implementation TBVAssetsGridViewCell
#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.selectedButton];
        [self layoutPageSubviews];
        
        RAC(self, selectedButton.selectedIndex) = [[RACObserve(self, viewModel.selectedIndex)
                                                        ignore:nil]
                                                        distinctUntilChanged];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentImageView.frame = self.bounds;
    
    CGRect frame = self.selectedButton.frame;
    frame.size = CGSizeMake(20, 20);
    frame.origin.x = self.bounds.size.width - 2 - frame.size.width;
    frame.origin.y = 2;
    self.selectedButton.frame = frame;
}

/* 用自动布局卡顿相对大些 */
- (void)layoutPageSubviews {
//    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
    
//    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(@20);
//        make.top.equalTo(self.contentView).offset(2);
//        make.right.equalTo(self.contentView).offset(-2);
//    }];
}

#pragma mark event chain
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(self.contentView.bounds.size.width * 0.5,
                                       0,
                                       self.contentView.bounds.size.width * 0.5,
                                       self.contentView.bounds.size.height * 0.5),
                            point)) {
        return self.selectedButton;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark public method
- (void)bindViewModel:(TBVAssetsGridItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    RAC(self, contentImageView.image) = [[[viewModel.contentImageSignal
        throttle:0.05]
        takeUntil:self.rac_prepareForReuseSignal]
        map:^id(RACTuple *value) {
            return [value first];
        }];
}

#pragma mark event response
- (void)selectedButtonOnClicked:(UIButton *)sender {
    [self.viewModel.didSelectCommand execute:self.viewModel.asset];
}

#pragma mark getter setter
- (UIImageView *)contentImageView
{
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contentImageView.clipsToBounds = YES;
    }
    
    return _contentImageView;
}
- (UIButton *)selectedButton
{
    if (_selectedButton == nil) {
        _selectedButton = [TBVAssetsPickerSelectButton selectButton];
        [_selectedButton addTarget:self action:@selector(selectedButtonOnClicked:) forControlEvents:UIControlEventTouchDown];
    }
    
    return _selectedButton;
}
@end
