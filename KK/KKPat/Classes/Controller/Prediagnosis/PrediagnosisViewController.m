//
//  PrediagnosisViewController.m
//  KKPat
//
//  Created by Wang on 27/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "PrediagnosisViewController.h"
#import "OrganListViewController.h"
#import "chooseOrganView.h"
#import "womenFrontOrganView.h"
#import "menBackView.h"
#import "womenBackView.h"

#import "KKConfiguration.h"
@interface PrediagnosisViewController ()

@property (nonatomic, strong) UIView *OrganView;


@property (nonatomic, strong) UIButton *MenBtn;

@property (nonatomic, strong) UIButton *WomenBtn;

@property (nonatomic, strong) UIButton *SwitchBtn;
@end

@implementation PrediagnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initStyle];
    [self.view addSubview:self.OrganView];
    [self.view addSubview:self.MenBtn];
    [self.view addSubview:self.WomenBtn];
    [self.view addSubview:self.SwitchBtn];
}


- (void)initStyle
{
    //导航栏返回按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [btn setImage:IMG(@"back1_btn") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    //默认图为男性
    chooseOrganView *MenView = [[chooseOrganView alloc]initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
    [self.OrganView addSubview:MenView];
}

- (void)viewDidLayoutSubviews
{

    [self.MenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-80);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.width.equalTo(@51.5);
        make.height.equalTo(@50.5);
    }];
    [self.WomenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.MenBtn.mas_centerY);
        make.left.equalTo(self.MenBtn.mas_right).offset(30);
        make.width.equalTo(@46.5);
        make.height.equalTo(@48);
    }];
    [self.SwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.WomenBtn.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.width.equalTo(@81);
        make.height.equalTo(@35.5);
    }];
    
}

- (void)backMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)SwitchImage:(UIButton *)sender
{
    for (UIView *view in self.OrganView.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"chooseOrganView")]) {
            if (sender.tag == 2011) {
                [view removeFromSuperview];
                womenFrontOrganView *WomenView = [[womenFrontOrganView alloc]initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
                [self.OrganView addSubview:WomenView];
            }
        }
        if ([view isKindOfClass:NSClassFromString(@"womenFrontOrganView")]) {
            if (sender.tag == 2010) {
                [view removeFromSuperview];
                chooseOrganView *MenView = [[chooseOrganView alloc]initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
                [self.OrganView addSubview:MenView];
            }
        }
    }
}

- (void)SwitchAction:(UIButton *)sender
{
    self.SwitchBtn.selected = !self.SwitchBtn.selected;
    for (UIView *view in self.OrganView.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"chooseOrganView")]) {
                [view removeFromSuperview];
            menBackView *BackView = [[menBackView alloc] initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
                [self.OrganView addSubview:BackView];
        }
        if ([view isKindOfClass:NSClassFromString(@"menBackView")]) {
            [view removeFromSuperview];
            chooseOrganView *MenView = [[chooseOrganView alloc]initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
            [self.OrganView addSubview:MenView];
        }
        if ([view isKindOfClass:NSClassFromString(@"womenFrontOrganView")]) {
                [view removeFromSuperview];
                womenBackView *backWomenView = [[womenBackView alloc] initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
                [self.OrganView addSubview:backWomenView];
        }
        if ([view isKindOfClass:NSClassFromString(@"womenBackView")]) {
                [view removeFromSuperview];
                womenFrontOrganView *womenFrontView = [[womenFrontOrganView alloc] initWithFrame:CGRectMake(0, 0, self.OrganView.bounds.size.width, self.OrganView.bounds.size.height)];
                [self.OrganView addSubview:womenFrontView];
        }
    }
}
- (UIView *)OrganView
{
    if (!_OrganView) {
        _OrganView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-80)];
    }
    return _OrganView;
}

- (UIButton *)MenBtn
{
    if (!_MenBtn) {
        _MenBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_MenBtn  setImage:IMG(@"man_Organ_image") forState:UIControlStateNormal];
        _MenBtn.tag = 2010;
        [_MenBtn addTarget:self action:@selector(SwitchImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MenBtn;
}
- (UIButton *)WomenBtn
{
    if (!_WomenBtn) {
        _WomenBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_WomenBtn setImage:IMG(@"woman_Organ_image") forState:UIControlStateNormal];
        _WomenBtn.tag = 2011;
        [_WomenBtn addTarget:self action:@selector(SwitchImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WomenBtn;
}
- (UIButton *)SwitchBtn
{
    if (!_SwitchBtn) {
        _SwitchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_SwitchBtn setImage:IMG(@"switch_Organ_btn") forState:UIControlStateNormal];
        [_SwitchBtn setImage:IMG(@"SwitchBack_Organ_image") forState:UIControlStateSelected];
        _SwitchBtn.adjustsImageWhenHighlighted = NO;
        [_SwitchBtn addTarget:self action:@selector(SwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SwitchBtn;
}
@end
