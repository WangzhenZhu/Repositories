//
//  KKPMessageViewController.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPMessageViewController.h"
#import "messageCell.h"
#import "KKConfiguration.h"

static NSString *messageCellID = @"messageCellID";
@interface KKPMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *messageTableView;
@end

@implementation KKPMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"messageCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
- (UITableView *)messageTableView
{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight) style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _messageTableView;
}
@end
