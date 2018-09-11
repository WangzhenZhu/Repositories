//
//  answerCell.m
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "answerCell.h"
#import "KKConfiguration.h"
#import "answersModel.h"

@interface answerCell()

@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, strong) UIView *answerView;

@property (nonatomic, strong) UILabel *answerLab;

@end
@implementation answerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rightImage];
        [self.contentView addSubview:self.answerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    [self.answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImage.mas_left).offset(-10);
        make.top.equalTo(self.rightImage.mas_top);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    [self.answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.answerView.mas_top);
        make.left.equalTo(self.answerView.mas_left);
        make.right.equalTo(self.answerView.mas_right);
        make.bottom.equalTo(self.answerView.mas_bottom);
    }];
}

- (void)refreshViewWithModel:(answersModel *)answerModel
{
    self.answerLab.text = answerModel.answerText;
}
- (UILabel *)answerLab
{
    if (!_answerLab) {
        _answerLab = [[UILabel alloc] init];
        [_answerLab setFont: [UIFont systemFontOfSize:15 weight:1]];
        [_answerLab setTextColor:[UIColor whiteColor]];
        _answerLab.textAlignment = NSTextAlignmentCenter;
    }
    return _answerLab;
}

- (UIView *)answerView
{
    if (!_answerView) {
        _answerView = [[UIView alloc] init];
        [_answerView addSubview:self.answerLab];
        _answerView.backgroundColor = ThemeColor;
        _answerView.layer.cornerRadius = 5.0f;
        _answerView.layer.masksToBounds = YES;
    }
    return _answerView;
}

- (UIImageView *)rightImage
{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] init];
        _rightImage.image = IMG(@"circle_consult_right");
    }
    return _rightImage;
}

@end
