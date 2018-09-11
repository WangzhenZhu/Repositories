//
//  KKPMyPatientViewController.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPMyPatientViewController.h"
#import "KKConfiguration.h"
#import "myPatientCell.h"

static NSString *myPatientCellID = @"myPatientCellID";
@interface KKPMyPatientViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myPatientTableView;
@end

@implementation KKPMyPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myPatientTableView];
      self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark --UITableViewDelegate

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
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:myPatientCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"myPatientCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

- (UITableView *)myPatientTableView
{
    if (!_myPatientTableView) {
        _myPatientTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _myPatientTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myPatientTableView.delegate = self;
        _myPatientTableView.dataSource = self;
    }
    return _myPatientTableView;
}

@end
