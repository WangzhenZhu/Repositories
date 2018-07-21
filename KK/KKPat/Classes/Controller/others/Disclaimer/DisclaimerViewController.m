//
//  DisclaimerViewController.m
//  KKPat
//
//  Created by Wang on 16/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "KKColors.h"
#import "RefuseViewController.h"
#import "KKConfiguration.h"
@interface DisclaimerViewController ()
@property (weak, nonatomic) IBOutlet UITextView *DisclaimerTextView;
@property (weak, nonatomic) IBOutlet UIView *DisclaimerContrainer;
@property (weak, nonatomic) IBOutlet UIButton *RefuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *AgreenBtn;

@end

@implementation DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DisclaimerTextView.editable = NO;
    self.DisclaimerContrainer.layer.borderColor = RGBACG(105, 180, 170, 1.0f);
    self.DisclaimerContrainer.layer.borderWidth = 1.0f;
    self.DisclaimerContrainer.layer.cornerRadius = 10.0f;
    self.DisclaimerContrainer.layer.masksToBounds = YES;
    
    [self.RefuseBtn addTarget:self action:@selector(goToRefuseVc) forControlEvents:UIControlEventTouchUpInside];
    [self.AgreenBtn addTarget:self action:@selector(goToAgreenVc) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)goToRefuseVc
{
    RefuseViewController *RefuseVc = [[RefuseViewController alloc] init];
    [self presentViewController:RefuseVc animated:YES completion:nil];
}

- (void)goToAgreenVc
{
    [[KKUserDefaults sharedInstance] setBoolValue:YES withKey:@"IsAgreenDisclaime"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
