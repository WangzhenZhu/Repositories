//
//  KKPRealTimeViewController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPRealTimeViewController.h"
#import "KKPDoctorInfoViewController.h"
#import "KKConfiguration.h"
#import "RealTimeDoctorCell.h"
#import "SearchView.h"
#import "realDoctorModel.h"
#import "KKRealDoctorListManager.h"
#import "KKSearchDoctorManager.h"

static NSString *RealTimeDoctorCellID = @"RealTimeDoctorCellID";

@interface KKPRealTimeViewController()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,KKAPIManagerApiCallBackDelegate, KKAPIManagerParamSourceDelegate>


@property (nonatomic, strong) UITableView *doctorList;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, strong) UIButton *BlackBtn;

@property (nonatomic, strong) KKRealDoctorListManager *DoctorListManager;

@property (nonatomic, strong) KKSearchDoctorManager *SearchManager;

@property (nonatomic, strong) NSMutableArray *doctorListArr;

@property (nonatomic, assign) NSInteger page;


@end

@implementation KKPRealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = self.findDoctorSearch;
    self.view.backgroundColor = [UIColor whiteColor];
   // [self addSearchbar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.doctorList];
    [self.view addSubview:self.searchView];
    [self loadData];
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
        make.bottom.equalTo(self.view.mas_bottom).offset(-45);
    }];
}


//- (void)addSearchbar
//{
//    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(18, 0.0f,ScreenWidth - 2*18, 0.0f)];
//    UITextField *searchField = [searchbar valueForKey:@"searchField"];
//
////    searchbar.delegate = self;
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
//   searchField.attributedPlaceholder = attStr;
//
//   // searchField
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
- (void)loadData
{
    self.page = 1;
    [SVProgressHUD show];
    [self.DoctorListManager loadData];
}
- (void)dropDownLoadData
{
    self.page = 1;
    
    [self.DoctorListManager loadData];
}
- (void)pullUpLoadData
{
    self.page++;
    [self.DoctorListManager loadData];
    
}
#pragma mark --KKAPIManagerParamSourceDelegate
- (NSDictionary *)paramForApi:(KKAPIBaseManager *)manager
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSNumber *token = [[KKUserDefaults sharedInstance] valueForKey:@"Token"];
    [params setObject:token forKey:@"token"];
    if ([manager isKindOfClass:[KKRealDoctorListManager class]]) {
        [params setObject:@0 forKey:@"pattern"];
        [params setObject:[NSNumber numberWithInteger:self.page] forKey:@"pageNo"];
        [params setObject:[NSNumber numberWithInteger:kERPageSize] forKey:@"pageSize"];
        return params;
    }
    if ([manager isKindOfClass:[KKSearchDoctorManager class]]) {
        [params setObject:@0 forKey:@"pattern"];
        [params setObject:self.searchView.searchField.text forKey:@"name"];
        return params;
    }
    return nil;
}
#pragma --KKAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(KKAPIBaseManager *)manager
{
    [self.doctorList.mj_header endRefreshing];
    [self.doctorList.mj_footer endRefreshing];
    [self.doctorListArr removeAllObjects];
    [self.doctorList reloadData];
    id responseData = manager.responseObject;
    if ([manager isKindOfClass:[KKRealDoctorListManager class]] || [manager isKindOfClass:[KKSearchDoctorManager class]]) {
        NSNumber *errorCode = [responseData valueForKey:@"code"];
        if (errorCode && [errorCode integerValue] == 200) {
             [SVProgressHUD dismiss];
                NSArray *list = [responseData valueForKey:@"data"];
                if (list && list.count > 0) {
                    [self.doctorListArr addObjectsFromArray:list];
                    [self.doctorList reloadData];
                }
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseData valueForKey:@"msg"]];
        }
    }
}
- (void)managerCallAPIDidFailed:(KKAPIBaseManager *)manager
{
    [SVProgressHUD showErrorWithStatus:manager.errorMessage];
}

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
        [self.SearchManager loadData];
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
    return _doctorListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RealTimeDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:RealTimeDoctorCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RealTimeDoctorCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    realDoctorModel *DoctorModel = [realDoctorModel yy_modelWithDictionary:self.doctorListArr[indexPath.row]];
    [cell refreshViewWithData:DoctorModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKPDoctorInfoViewController *doctorInfoVc = [[KKPDoctorInfoViewController alloc] init];
    realDoctorModel *DoctorModel = [realDoctorModel yy_modelWithDictionary:self.doctorListArr[indexPath.row]];
    doctorInfoVc.title = @"医生简介";
    doctorInfoVc.realModel = DoctorModel;
    [self.navigationController pushViewController:doctorInfoVc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
//#pragma mark -- UISearchBarDelegate
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [searchBar resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

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

- (UITableView *)doctorList
{
    if (!_doctorList) {
        _doctorList = [[UITableView alloc] init];
        _doctorList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _doctorList.showsVerticalScrollIndicator = NO;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownLoadData)];
//        header.lastUpdatedTimeLabel.hidden = YES;
        _doctorList.mj_header = header;
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpLoadData)];
//
//        _doctorList.mj_footer = footer;
        _doctorList.delegate = self;
        _doctorList.dataSource = self;
    }
    return _doctorList;
}

- (UIButton *)BlackBtn
{
    if (!_BlackBtn) {
        _BlackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    }
    return _BlackBtn;
}

- (KKRealDoctorListManager *)DoctorListManager
{
    if (!_DoctorListManager) {
        _DoctorListManager = [[KKRealDoctorListManager alloc] init];
        _DoctorListManager.delegate = self;
        _DoctorListManager.paramsSource = self;
    }
    return _DoctorListManager;
}
- (KKSearchDoctorManager *)SearchManager
{
    if (!_SearchManager) {
        _SearchManager = [[KKSearchDoctorManager alloc] init];
        _SearchManager.delegate = self;
        _SearchManager.paramsSource = self;
    }
    return _SearchManager;
}
- (NSMutableArray *)doctorListArr
{
    if (!_doctorListArr) {
        _doctorListArr = [[NSMutableArray alloc] init];
    }
    return _doctorListArr;
}
@end
