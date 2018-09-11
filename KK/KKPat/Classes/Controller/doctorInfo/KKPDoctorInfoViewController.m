//
//  KKPDoctorInfoViewController.m
//  KKPat
//
//  Created by Wang on 28/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPDoctorInfoViewController.h"
#import "KKConfiguration.h"

#import "doctorInfoView.h"

#import "realDoctorModel.h"

@interface KKPDoctorInfoViewController ()

@property (nonatomic, strong) UIScrollView *doctorInfoScroll;

@property (nonatomic, strong) UIButton *sendRequestBtn;

@property (nonatomic, strong) doctorInfoView *docView;
@end

@implementation KKPDoctorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.doctorInfoScroll addSubview:self.docView];
    [self.doctorInfoScroll addSubview:self.sendRequestBtn];
    [self.view addSubview:self.doctorInfoScroll];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLayoutSubviews
{
    [self.doctorInfoScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-45);
    }];
}
- (UIScrollView *)doctorInfoScroll
{
    if (!_doctorInfoScroll) {
        _doctorInfoScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _doctorInfoScroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.sendRequestBtn.frame)+50);
        _doctorInfoScroll.showsVerticalScrollIndicator = NO;
        _doctorInfoScroll.bounces = NO;
        
    }
    return _doctorInfoScroll;
}

- (UIButton *)sendRequestBtn
{
    if (!_sendRequestBtn) {
        _sendRequestBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, 610,ScreenWidth-18*2 , 40)];
        _sendRequestBtn.layer.cornerRadius = 20;
        _sendRequestBtn.layer.masksToBounds = YES;
        [_sendRequestBtn setTitle:@"发送请求" forState:UIControlStateNormal];
        [_sendRequestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendRequestBtn setBackgroundColor:ThemeColor];
    }
    return _sendRequestBtn;
}

- (doctorInfoView *)docView
{
    if (!_docView) {
        _docView = [[doctorInfoView alloc] init];
        _docView.sexLab.text = [self.realModel.sex integerValue] ? @"女":@"男";
        _docView.ageLab.text = [NSString stringWithFormat:@"%@",self.realModel.age];
        _docView.consultCountLab.text = [NSString stringWithFormat:@"%@",self.realModel.consultCount];
        [_docView.doctorAvatar sd_setImageWithURL:[NSURL URLWithString:self.realModel.photo?:@""] placeholderImage:IMG(@"")];
        _docView.titleLab.text = [NSString stringWithFormat:@"正在向%@咨询",self.realModel.name];
        CGRect rect = [self getLabelString:self.realModel.speciality CGRectWith:_docView.specialityLab.font WithSize:CGSizeMake(200, 2000)];
        _docView.specialityLabHeight.constant = rect.size.height;
        [_docView.specialityLab setNeedsLayout];
        _docView.specialityLab.text = self.realModel.speciality;
        _docView.departmentLab.text = self.realModel.department;
        _docView.categoryLab.text = self.realModel.category;
        _docView.educationLab.text = self.realModel.diploma;
        _docView.hospitalLab.text = self.realModel.hospital;
        
    }
    return _docView;
}

- (CGRect )getLabelString:(NSString *)str CGRectWith:(UIFont *)font WithSize:(CGSize )labelSize
{
    return [str boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
}
@end
