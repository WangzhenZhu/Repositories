//
//  KKPRealTimeViewController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPRealTimeViewController.h"

@interface KKPRealTimeViewController()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) UITableView *
@end

@implementation KKPRealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSearchbar];
    self.view.backgroundColor = [UIColor grayColor];
   
    // Do any additional setup after loading the view.
}

- (void)addSearchbar
{
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,1000.0f,0.0f)];
    searchbar.delegate = self;
    [searchbar setBarTintColor:[UIColor redColor]];
    [searchbar setPlaceholder:@"一键寻医"];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithCustomView:searchbar];
    self.navigationItem.rightBarButtonItem = searchButton;
}

-

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
