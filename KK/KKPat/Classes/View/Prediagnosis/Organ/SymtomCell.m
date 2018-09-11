//
//  SymtomCell.m
//  KKPat
//
//  Created by Wang on 2018/9/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "SymtomCell.h"
#import "KKConfiguration.h"

@interface SymtomCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation SymtomCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(KKSymtomCellType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellType = type;
        if (self.cellType == KKSymtomCellTypeBody) {
            [self setBackgroundColor:RGB(241, 241, 241)];
        }
        else if (self.cellType == KKSymtomCellTypeBody)
        {
            [self setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:self.titleLabel];
        [self addSubview:self.line];
    }
    return self;
}

#pragma mark - view lifecycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setText:self.title];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_height);
    }];
    if (self.cellType == KKSymtomCellTypeBody) {
        if (self.selectStatus) {
            [self setBackgroundColor:[UIColor whiteColor]];
        }
        else {
            [self setBackgroundColor:RGB(241, 241, 241)];
        }
        [self.line setHidden:YES];
    }
    else if (self.cellType == KKSymtomCellTypeSymtom)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).offset(-1);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@0.5);
        }];
    }
}

#pragma mark -getters and setters
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: RGB(51, 51, 51)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _titleLabel;
}

- (UIView *)line
{
    if (_line == nil) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor: RGB(221, 221, 221)];
    }
    return _line;
}

@end
