//
//  KKPNavController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPNavController.h"
#import "KKConfiguration.h"
@interface KKPNavController ()

@end

@implementation KKPNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = ThemeColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}



@end
