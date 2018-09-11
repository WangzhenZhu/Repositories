//
//  singleSelectionCell.m
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "singleSelectionCell.h"
#import "KKConfiguration.h"
#import "questionModel.h"
#import "answersModel.h"
#import "SingleSelectButton.h"

@interface singleSelectionCell()

@property (nonatomic, strong) UIImageView *grayImage;

@property (nonatomic, strong) UIView *dialogBoxView;

@property (nonatomic, strong) UILabel *questionsLab;

@property (nonatomic, strong) UIView *verticalView;

@end
@implementation singleSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.grayImage];
        [self.contentView addSubview:self.dialogBoxView];
        [self.contentView addSubview:self.verticalView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.grayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@25);
        make.height.mas_equalTo(self.grayImage.mas_width);
    }];
    [self.dialogBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.grayImage.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.questionsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dialogBoxView.mas_left).offset(10);
        make.top.equalTo(self.dialogBoxView.mas_top).offset(10);
//        make.right.equalTo(self.dialogBoxView.mas_right).offset(-10);
    
//        make.height.equalTo(@100);
    }];
    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(10);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)refreshStyleWithModel:(questionModel *)questionModel withSelectedId:(NSNumber *)selectId
{
    
    self.questionsLab.text = questionModel.questionText;
    
    [self addChooseBtnWithAnswers:questionModel.answers withSelectedId:selectId];
}

- (void)addChooseBtnWithAnswers:(NSArray<answersModel *> *)answers withSelectedId:(NSNumber *)selectId
{
    NSMutableArray *arrayBtn = [NSMutableArray array];
    for (int i = 0; i < answers.count; i++) {
//      WithFrame:CGRectMake(10, 50+5+40*i, 100, 30)
        SingleSelectButton *answerBtn = [[SingleSelectButton alloc]init];
//        [answerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.questionsLab.mas_bottom).offset(5+40*i);
//            make.left.equalTo(self.questionsLab.mas_left);
//            make.height.equalTo(@40);
//            make.width.equalTo(@100);
//        }];
        [answerBtn setImage:IMG(@"no_consult_btn") forState:UIControlStateNormal];
        [answerBtn setImage:IMG(@"yes_consult_btn") forState:UIControlStateSelected];
        answerBtn.selectAnswer = answers[i];
        answerBtn.selectId = i;
        [answerBtn setTitle:[answers[i] valueForKey:@"answerText"] forState:UIControlStateNormal];
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        answerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        if (!selectId) {
            //没有被选
          [answerBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            //被选 将被选的按钮选中
            if (i == [selectId integerValue]) {
                answerBtn.selected = YES;
            }
        }
    //    [answerBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0,0)];
        [answerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0,0)];
     
        [self.dialogBoxView addSubview:answerBtn];
        [arrayBtn addObject:answerBtn];
     
    }
//    [self.verticalView addSubview:arrayBtn];
//    self.verticalView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:self.verticalView];
//    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.equalTo(@0);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth/answers.count, 25));
//    }];
    [arrayBtn mas_distributeViewsAlongAxis:MASAxisTypeVertical
                                    withFixedSpacing:10
                                    leadSpacing:0
                                    tailSpacing:0];
    [arrayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.equalTo(@10);
    }];
}

- (void)chooseAction:(SingleSelectButton *)sender;
{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(choosedAction:withSelected:)]) {
        [self.delegate choosedAction:sender.selectAnswer withSelected:sender.selectId];
    }
}
- (UIImageView *)grayImage
{
    if (!_grayImage) {
        _grayImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _grayImage.image = IMG(@"circle_consult_left");
    }
    return _grayImage;
}

- (UIView *)dialogBoxView
{
    if (!_dialogBoxView) {
        _dialogBoxView = [[UIView alloc] init];
        _dialogBoxView.layer.cornerRadius = 8.f;
        _dialogBoxView.layer.masksToBounds = YES;
        _dialogBoxView.layer.borderColor = RGBACG(222, 222, 222, 1);
        _dialogBoxView.layer.borderWidth = 1.f;
        [_dialogBoxView addSubview:self.questionsLab];
    }
    return _dialogBoxView;
}

- (UILabel *)questionsLab
{
    if (!_questionsLab) {
        _questionsLab = [[UILabel alloc] init];
        [_questionsLab setTextColor:RGB(20, 20, 20)];
        [_questionsLab setFont:[UIFont systemFontOfSize:14]];
    }
    return _questionsLab;
}
- (UIView *)verticalView
{
    if (!_verticalView) {
        _verticalView = [[UIView alloc] init];
    }
    return _verticalView;
}
@end
