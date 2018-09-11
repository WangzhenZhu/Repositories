//
//  headQuestionView.m
//  KKPat
//
//  Created by Wang on 2018/9/10.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "headQuestionView.h"
#import "PreParamModel.h"

@interface headQuestionView()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menBtn;

@property (weak, nonatomic) IBOutlet UIButton *womenBtn;

@property (weak, nonatomic) IBOutlet UITextField *heightText;

@property (weak, nonatomic) IBOutlet UITextField *weightText;

@property (weak, nonatomic) IBOutlet UITextField *ageText;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation headQuestionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"headQuestionView" owner:nil options:nil].firstObject;
        self.okBtn.layer.cornerRadius = 5.f;
        self.okBtn.layer.masksToBounds = YES;
        [self.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.womenBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.menBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.womenBtn addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        [self.menBtn addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}

- (void)okAction
{
    PreParamModel *model = [[PreParamModel alloc] init];
    model.sex = self.womenBtn.selected?@2:@1;
    model.age =   @([self.ageText.text integerValue]);
    model.height = @([self.heightText.text integerValue]);
    model.weight = @([self.weightText.text integerValue]);
    self.inputParamBlock(model);
    
}


- (void)chooseSex:(UIButton *)sender
{
    if (self.womenBtn == sender) {
        self.womenBtn.selected = YES;
        self.menBtn.selected = NO;
    }
    if (self.menBtn == sender) {
        self.womenBtn.selected = NO;
        self.menBtn.selected = YES;
    }
}

@end
