//
//  orderHeadView.m
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "orderHeadView.h"
#import "KKConfiguration.h"


@interface orderHeadView()


@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel *leftLab;

@property (nonatomic, strong) UILabel *rightLab;
@end

@implementation orderHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.frame = frame;
//        self.frame = CGRectMake(0, 4, ScreenWidth*0.9, 40);
        self.width = self.bounds.size.width;
        self.height = self.bounds.size.height;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.bounds.size.height * 0.5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = RGBACG(244, 244, 244, 1);
        self.layer.borderWidth = 1.0f;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.sliderScroll];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(@((self.width-10)*0.5));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(@((self.width-10)*0.5));
    }];
    [self.sliderScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(@((self.width-10)*0.5));
    }];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sliderScroll.mas_left);
        make.top.equalTo(self.sliderScroll.mas_top);
        make.bottom.equalTo(self.leftBtn.mas_bottom);
        make.width.equalTo(self.leftBtn.mas_width);
    }];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLab.mas_right);
        make.top.equalTo(self.sliderScroll.mas_top);
        make.bottom.equalTo(self.rightBtn.mas_bottom);
        make.width.equalTo(self.rightBtn.mas_width);
    }];
    

}

- (void)leftBtnAction
{
    self.sliderScroll.frame = self.leftBtn.frame;
    CGPoint point = CGPointMake(_leftLab.frame.origin.x, _leftLab.frame.origin.y);
    self.sliderScroll.contentOffset = point;
    if (_delegate && [_delegate respondsToSelector:@selector(ScrollFollowWithLeftButton)]) {
        [_delegate ScrollFollowWithLeftButton];
    }
    
}

- (void)rightBtnAction
{
    self.sliderScroll.frame = self.rightBtn.frame;
    CGPoint point = CGPointMake(_rightLab.frame.origin.x, _rightLab.frame.origin.y);
    self.sliderScroll.contentOffset = point;
    if (_delegate && [_delegate respondsToSelector:@selector(ScrollFollowWithRightButton)]) {
        [_delegate ScrollFollowWithRightButton];
    }
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:@"正在进行" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _leftBtn.layer.cornerRadius = (_height - 10) * 0.5;
        _leftBtn.layer.masksToBounds = YES;
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"历史订单" forState:UIControlStateNormal];
         [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rightBtn.layer.cornerRadius = (_height- 10) * 0.5;
        _rightBtn.layer.masksToBounds = YES;
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIScrollView *)sliderScroll
{
    if (!_sliderScroll) {
     
        _sliderScroll = [[UIScrollView alloc] init];
        _sliderScroll.backgroundColor = ThemeColor;
        _sliderScroll.scrollEnabled = NO;
        _sliderScroll.layer.cornerRadius = (_height-10)*0.5;
        _sliderScroll.layer.masksToBounds = YES;
        _sliderScroll.contentSize = CGSizeMake(_width-10, _height-10);
        _sliderScroll.showsHorizontalScrollIndicator = NO;
        _sliderScroll.showsVerticalScrollIndicator = NO;
        [_sliderScroll addSubview:self.leftLab];
        [_sliderScroll addSubview:self.rightLab];
        
    }
    return _sliderScroll;
}

- (UILabel *)leftLab
{
    if (!_leftLab) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.text = @"正在进行";
        [_leftLab setTextColor:[UIColor whiteColor]];
        _leftLab.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLab;
}

- (UILabel *)rightLab
{
    if (!_rightLab) {
        _rightLab = [[UILabel alloc] init];
         _rightLab.textAlignment = NSTextAlignmentCenter;
        [_rightLab setTextColor:[UIColor whiteColor]];
        _rightLab.text = @"历史订单";
    }
    return _rightLab;
}
@end
