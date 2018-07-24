//
//  RefuseViewController.m
//  KKPat
//
//  Created by Wang on 16/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "RefuseViewController.h"

@interface RefuseViewController ()

@property (weak, nonatomic) IBOutlet UIButton *BackBtn;

@end

@implementation RefuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.BackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}


- (void)backAction
{
    
   // [[self dismissViewControllerAnimated:NO completion:nil] ]
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
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
