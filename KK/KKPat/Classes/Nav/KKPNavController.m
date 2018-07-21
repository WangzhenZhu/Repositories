//
//  KKPNavController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPNavController.h"
#import "KKConfiguration.h"
@interface KKPNavController ()<UISearchBarDelegate>

@end

@implementation KKPNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = ThemeColor;
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
