//
//  TBVAssetsCollectionViewCell.m
//  TBVAssetsPicker
//
//  Created by tripleCC on 8/25/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "TBVAssetsCollectionViewCell.h"
#import "TBVAssetsCollectionItemViewModel.h"
#import "TBVCollection.h"

@interface TBVAssetsCollectionViewCell()
@property (strong, nonatomic) UIImageView *posterImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *separateLineView;
@property (strong, nonatomic) TBVAssetsCollectionItemViewModel *viewModel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@end

@implementation TBVAssetsCollectionViewCell
#pragma mark life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.posterImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.separateLineView];
        [self.contentView addSubview:self.arrowImageView];
        [self layoutPageSubviews];
        RAC(self, titleLabel.text) = [RACObserve(self, viewModel.title) distinctUntilChanged];
        
        @weakify(self)
        [self.rac_prepareForReuseSignal subscribeNext:^(id x) {
            @strongify(self)
            //TODO: 可以改成默认图片
            self.posterImageView.image = nil;
        }];
    }
    return self;
}

- (void)layoutPageSubviews {
    [self.posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posterImageView.mas_right).offset(15);
        make.top.bottom.equalTo(self.posterImageView);
    }];
    
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.left.right.equalTo(self.contentView);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
}

#pragma mark public method
- (void)bindViewModel:(TBVAssetsCollectionItemViewModel *)viewModel {
    self.viewModel = viewModel;
    RAC(self, posterImageView.image) = [[[viewModel.posterImageSignal
        throttle:0.05]
        takeUntil:self.rac_prepareForReuseSignal]
        map:^id(RACTuple *value) {
            return [value first];
        }];
}

#pragma mark getter setter
- (UIImageView *)posterImageView
{
    if (_posterImageView == nil) {
        _posterImageView = [[UIImageView alloc] init];
        _posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        _posterImageView.backgroundColor = [UIColor lightGrayColor];
        _posterImageView.clipsToBounds = YES;
    }
    
    return _posterImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor grayColor];
    }
    
    return _titleLabel;
}

- (UIView *)separateLineView
{
    if (_separateLineView == nil) {
        _separateLineView = [[UIView alloc] init];
        _separateLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    
    return _separateLineView;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"asset_picker_icon_arrow"];
    }
    
    return _arrowImageView;
}
@end
