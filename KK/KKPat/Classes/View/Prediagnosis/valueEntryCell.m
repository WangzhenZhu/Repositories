//
//  valueEntryCell.m
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "valueEntryCell.h"
#import "questionModel.h"
#import "answersModel.h"
#import "entrieModel.h"
#import "KKConfiguration.h"

@interface valueEntryCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *grayImage;

@property (nonatomic, strong) UIView *dialogBoxView;

@property (nonatomic, strong) UILabel *questionsLab;

@property (nonatomic, strong) UITextField *answerTextField;

@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, strong) answersModel *answerModel;

//@property (nonatomic, strong) entrieModel *entriesModel;


@end
@implementation valueEntryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.grayImage];
        [self addSubview:self.dialogBoxView];
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
        make.height.equalTo(@25);
    }];
    [self.dialogBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.grayImage.mas_right).offset(10);
        make.top.equalTo(self.grayImage.mas_top);
        make.right.equalTo(self.mas_right).offset(-50);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.questionsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dialogBoxView.mas_left).offset(10);
        make.top.equalTo(self.dialogBoxView.mas_top).offset(10);
        make.height.equalTo(@40);
    }];
    [self.answerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.questionsLab.mas_left);
        make.top.equalTo(self.questionsLab.mas_bottom).offset(10);
        make.right.equalTo(self.dialogBoxView.mas_right).offset(-20);
        make.height.equalTo(@40);
    }];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dialogBoxView.mas_centerX);
        make.bottom.equalTo(self.dialogBoxView.mas_bottom).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
}

- (void)refreshStyleWithData:(questionModel *)questionModel
{
    self.questionsLab.text = questionModel.questionText;
    self.answerModel =  questionModel.answers[0];
      NSString *valueType = [[self.answerModel valueForKey:@"entriersModel"] valueForKey:@"valueType"];
    if ([valueType isEqualToString:@"number"]) {
        self.answerTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
//    self.entrieModel = self.answersModel.entriersModel;
}

- (void)okAction
{
    self.answerModel.entriersModel.value = (NSNumber *)self.answerTextField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(okWithAnswer:)]) {
        [self.delegate okWithAnswer:self.answerModel];
    }
    NSLog(@"hahhhahah6");
}
#pragma mark -- TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 0 || string.length > 0) {
        self.okBtn.userInteractionEnabled = YES;
        return YES;
    }
    self.okBtn.userInteractionEnabled = NO;
    return YES;
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
        [_dialogBoxView addSubview:self.answerTextField];
        [_dialogBoxView addSubview:self.okBtn];
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

- (UITextField *)answerTextField
{
    if (!_answerTextField) {
        _answerTextField = [[UITextField alloc] init];
        _answerTextField.layer.cornerRadius = 8.f;
        _answerTextField.layer.masksToBounds = YES;
        _answerTextField.layer.borderColor = RGBACG(222, 222, 222, 1);
        _answerTextField.layer.borderWidth = 1.f;
        _answerTextField.delegate = self;
    }
    return _answerTextField;
}
- (UIButton *)okBtn
{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] init];
        [_okBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_okBtn setTitleColor:RGB(20, 20, 20) forState:UIControlStateNormal];
        _okBtn.userInteractionEnabled = NO;
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _okBtn.layer.cornerRadius = 5.0f;
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.borderWidth = 1;
        _okBtn.layer.borderColor = RGBACG(222, 222, 222, 1);
        [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _okBtn;
}
@end
