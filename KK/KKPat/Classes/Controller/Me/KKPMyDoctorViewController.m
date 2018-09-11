//
//  KKPMyDoctorViewController.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPMyDoctorViewController.h"
#import "KKConfiguration.h"
#import "myDoctorCell.h"

static NSString *myDoctorCellID = @"myDoctorCellID";
@interface KKPMyDoctorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITextField *searchHeader;

@property (nonatomic, strong) UITableView *myDoctorTable;
@end

@implementation KKPMyDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchHeader];
    [self.view addSubview:self.myDoctorTable];

    // Do any additional setup after loading the view.
}


#pragma mark -- TableViewDelegate
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
    return 140.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:myDoctorCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"myDoctorCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (UITextField *)searchHeader
{
    if (!_searchHeader) {
        _searchHeader = [[UITextField alloc] initWithFrame:CGRectMake(28, 16+64, ScreenWidth-28*2, 30)];
        _searchHeader.backgroundColor = RGBA(76, 182, 170, 0.2);
        _searchHeader.layer.cornerRadius = _searchHeader.bounds.size.height * 0.5;
        _searchHeader.layer.masksToBounds = YES;
        _searchHeader.layer.borderColor = ThemeColorACG;
        _searchHeader.layer.borderWidth = 1.f;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
        UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7, 3, 23, 23)];
        leftIcon.image = IMG(@"search_mydoctor_icon");
        [leftView addSubview:leftIcon];
        _searchHeader.leftView = leftView;
        _searchHeader.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchHeader;
}

- (UITableView *)myDoctorTable
{
    if (!_myDoctorTable) {
        _myDoctorTable = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchHeader.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(self.searchHeader.frame)) style:UITableViewStylePlain];
        _myDoctorTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myDoctorTable.showsVerticalScrollIndicator = NO;
        _myDoctorTable.delegate = self;
        _myDoctorTable.dataSource = self;
        
    }
    return _myDoctorTable;
}
@end
