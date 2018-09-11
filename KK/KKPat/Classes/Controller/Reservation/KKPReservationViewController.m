//
//  KKPReservationViewController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPReservationViewController.h"
#import "KKConfiguration.h"
#import "reservationCell.h"
#import "KKPDoctorInfoViewController.h"
#import "SearchView.h"

static NSString *reservationCellID = @"reservationCellID";

@interface KKPReservationViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, strong) UIButton *BlackBtn;

@property (nonatomic, strong) UITableView *doctorList;
@end

@implementation KKPReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.rightBarButtonItem = self.findDoctorSearch;
    self.view.backgroundColor = [UIColor grayColor];
//    [self addSearchbar];
    [self.view addSubview:self.doctorList];
    [self.view addSubview:self.searchView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-  (void)viewDidLayoutSubviews
{
    [self.doctorList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
//- (void)addSearchbar
//{
//    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(18, 0.0f,ScreenWidth - 2*18, 0.0f)];
//    UITextField *searchField = [searchbar valueForKey:@"searchField"];
//    searchField.backgroundColor = RGBA(255, 255, 255, 0.5);
//    searchField.layer.cornerRadius = 14.0f;
//    UIImageView *lefticonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//    lefticonView.image = IMG(@"search_realTime_icon");
//    searchField.leftView = lefticonView;
//
//    //修改placeholder
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17]; // 设置font
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
//    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"一键寻医" attributes:attrs]; // 初始化富文本占位字符串
//    searchField.attributedPlaceholder = attStr;
//
//    // searchField
//    NSLog(@"kklll--%f",searchField.bounds.size.height);
//    searchField.layer.masksToBounds = YES;
//
//
//    [searchbar setPlaceholder:@"一键寻医"];
//    [searchbar setTintColor: [UIColor whiteColor]];
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:searchbar];
//    self.navigationItem.rightBarButtonItem = searchButton;
//    searchbar.delegate = self;
//}
#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.BlackBtn.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.BlackBtn addTarget:self action:@selector(moveBlackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.BlackBtn];
}

- (void)moveBlackBtn:(UIButton *)sender
{
    [sender removeFromSuperview];
    [self.searchView.searchField resignFirstResponder];
    NSLog(@"kkk");
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [self.searchView.searchField resignFirstResponder];
        [self.BlackBtn removeFromSuperview];
        return NO;
    }
    return YES;
}


#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    reservationCell *cell = [tableView dequeueReusableCellWithIdentifier:reservationCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"reservationCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKPDoctorInfoViewController *doctorInfoVc = [[KKPDoctorInfoViewController alloc] init];
    doctorInfoVc.title = @"医生简介";
    [self.navigationController pushViewController:doctorInfoVc animated:YES];
}
- (UITableView *)doctorList
{
    if (!_doctorList) {
        _doctorList = [[UITableView alloc] init];
        _doctorList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _doctorList.showsVerticalScrollIndicator = NO;
        _doctorList.delegate = self;
        _doctorList.dataSource = self;
    }
    return _doctorList;
}

- (SearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[SearchView alloc] init];
        _searchView.searchField.delegate = self;
        _searchView.layer.shadowColor = RGBACG(0, 0, 0, 0.3);
        _searchView.layer.shadowOffset = CGSizeMake(0, 15.f);
        _searchView.layer.shadowOpacity = 0.5;
    }
    return _searchView;
}

- (UIButton *)BlackBtn
{
    if (!_BlackBtn) {
        _BlackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    }
    return _BlackBtn;
}
@end
