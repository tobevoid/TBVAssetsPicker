//
//  TBVAssetsPickerSelectButton.m
//  Qiaobutang
//
//  Created by tripleCC on 9/2/16.
//  Copyright © 2016 chengfj. All rights reserved.
//

#import "TBVAssetsPickerSelectButton.h"

@implementation TBVAssetsPickerSelectButton

+ (instancetype)selectButton {
    TBVAssetsPickerSelectButton *selectButton = [TBVAssetsPickerSelectButton buttonWithType:UIButtonTypeCustom];
    return selectButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setImage:[UIImage imageNamed:@"asset_picker_not_selected"] forState:UIControlStateNormal];
        [self setImage:[UIImage new] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex == NSNotFound) {
        self.selected = NO;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 0;
        self.layer.borderWidth = 0;
    } else {
        self.selected = YES;
        [self setTitle:[NSString stringWithFormat:@"%ld", selectedIndex + 1] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor orangeColor];
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}
@end
