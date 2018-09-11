//
//  KKPMeViewController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPMeViewController.h"
#import "KKConfiguration.h"
#import "meHeadCell.h"
#import "loginOutCell.h"
#import "MeCell.h"

#import "KKPMessageViewController.h"
#import "KKPMyPatientViewController.h"
#import "KKPMedicalRecordViewController.h"
#import "KKPMyDoctorViewController.h"
#import "KKPSettingViewController.h"
#import "DisclaimerViewController.h"
#import "KKPInstructionsViewController.h"
#import "KKPFeedbackViewController.h"
#import "KKPAboutViewController.h"

static NSString *meHeadCellID = @"meHeadCellID";
static NSString *loginOutCellID = @"meHeadCellID";
static NSString *meCellID = @"MeCellID";
@interface KKPMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *meTableView;

@property (nonatomic, strong) NSArray *meArr;
@end

@implementation KKPMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.meArr = @[@[@"我的消息",@"我的就诊人",@"我的既往病历",@"我的医生"],@[@"设置"],@[@"免责声明",@"使用说明",@"反馈",@"为我们打分",@"关于我们"]];
    self.view.backgroundColor = [UIColor blueColor];

    [self.view addSubview:self.meTableView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;;
}

- (void)viewDidLayoutSubviews
{
    [self.meTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - TableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 4;
    }else if (section == 2) {
        return 1;
    }else if (section == 3) {
        return 5;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 206.0f;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3){
        return 50.0f;
    }else{
        return 60.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        meHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:meHeadCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"meHeadCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3)
    {
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MeCell" owner:nil options:nil] firstObject];
         }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refreshViewWithData:self.meArr[indexPath.section-1][indexPath.row]];
        return cell;
    }else{
        loginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:loginOutCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"loginOutCell" owner:nil options:nil] firstObject];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                KKPMessageViewController *messageVc = [[KKPMessageViewController alloc] init];
                messageVc.title = @"我的消息";
                [self.navigationController pushViewController:messageVc animated:YES];
            }
            if (indexPath.row == 1) {
                KKPMyPatientViewController *patientVc = [[KKPMyPatientViewController alloc] init];
                patientVc.title = @"我的就诊人";
                [self.navigationController pushViewController:patientVc animated:YES];
            }
            if (indexPath.row == 2) {
                KKPMedicalRecordViewController *recondVc = [[KKPMedicalRecordViewController alloc] init];
                recondVc.title = @"我的既往病历";
                [self.navigationController pushViewController:recondVc animated:YES];
            }
            if (indexPath.row == 3) {
                KKPMyDoctorViewController *doctorVc = [[KKPMyDoctorViewController alloc] init];
                doctorVc.title = @"我的医生";
                [self.navigationController pushViewController:doctorVc animated:YES];
            }
    }else if (indexPath.section == 2 ){
                KKPSettingViewController *settingVc = [[KKPSettingViewController alloc] init];
                settingVc.title = @"设置";
                [self.navigationController pushViewController:settingVc animated:YES];
    }else
    {
             if (indexPath.row == 0) {
                DisclaimerViewController *disclamVc = [[DisclaimerViewController alloc] init];
                disclamVc.title = @"免责声明";
                [self.navigationController pushViewController:disclamVc animated:YES];
             }
            if (indexPath.row == 1) {
                KKPInstructionsViewController *instructionVc = [[KKPInstructionsViewController alloc] init];
                instructionVc.title = @"使用说明";
                [self.navigationController pushViewController:instructionVc animated:YES];
            }
            if (indexPath.row == 2) {
                KKPFeedbackViewController *feedbackVc = [[KKPFeedbackViewController alloc] init];
                feedbackVc.title = @"反馈";
                [self.navigationController pushViewController:feedbackVc animated:YES];
            }
            if (indexPath.row == 3) {
                //链接到AppStore进行评分
            }
            if (indexPath.row == 4) {
                KKPAboutViewController *aboutVc = [[KKPAboutViewController alloc] init];
                aboutVc.title = @"关于我们";
                [self.navigationController pushViewController:aboutVc animated:YES];
            }
    }
}
- (UITableView *)meTableView
{
    if (!_meTableView) {
        _meTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _meTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _meTableView.bounces = NO;
        _meTableView.showsVerticalScrollIndicator = NO;
        _meTableView.delegate = self;
        _meTableView.dataSource = self;
    }
    return _meTableView;
}

@end
