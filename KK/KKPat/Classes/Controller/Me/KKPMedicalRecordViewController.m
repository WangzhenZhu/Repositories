//
//  KKPMedicalRecordViewController.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPMedicalRecordViewController.h"
#import "KKEditMedicalRecordViewController.h"
#import "MedicalRecordsView.h"
#import "KKConfiguration.h"
@interface KKPMedicalRecordViewController ()

@property (nonatomic, strong) UIScrollView *MedicalRecordScroll;

@property (nonatomic, strong) MedicalRecordsView *medicalView;

@property (nonatomic, assign) float Height;

@property (nonatomic, strong) UIButton *editMedicalRecordBtn;
@end

@implementation KKPMedicalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor whiteColor];
    [self addMedicalView];
    [self.MedicalRecordScroll addSubview:self.editMedicalRecordBtn];
    [self.view addSubview:self.MedicalRecordScroll];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)addMedicalView
{
    for (int i = 0; i < 2; i++) {
        MedicalRecordsView *medicalView = [[MedicalRecordsView alloc] initWithFrame:CGRectMake(30, 22+(256+22)*i, ScreenWidth-30*2, 256)];
        self.Height = CGRectGetMaxY(medicalView.frame);
        [self.MedicalRecordScroll addSubview:medicalView];
    }
}

- (void)clickEditBtn
{
    KKEditMedicalRecordViewController *editMedicalVc = [[KKEditMedicalRecordViewController alloc] init];
    [self.navigationController pushViewController:editMedicalVc animated:YES];
}
- (UIScrollView *)MedicalRecordScroll
{
    if (!_MedicalRecordScroll) {
        _MedicalRecordScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _MedicalRecordScroll.contentSize = CGSizeMake(ScreenWidth, 900);
        _MedicalRecordScroll.showsVerticalScrollIndicator = NO;
        
    }
    return _MedicalRecordScroll;
}

- (UIButton *)editMedicalRecordBtn
{
    if (!_editMedicalRecordBtn) {
        _editMedicalRecordBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-121)/2,self.Height + 20, 121, 26)];
        [_editMedicalRecordBtn setImage:IMG(@"edit_Medical_btn") forState:UIControlStateNormal];
        [_editMedicalRecordBtn setTitle:@"修改病历" forState:UIControlStateNormal];
        [_editMedicalRecordBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_editMedicalRecordBtn addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editMedicalRecordBtn;
}
@end
