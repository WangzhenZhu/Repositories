//
//  EntryInfoViewController.m
//  KKPat
//
//  Created by Wang on 17/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//


#import "EntryInfoViewController.h"
#import "KKPatTabBarController.h"
#import "KKConfiguration.h"
#import "InfoHeadView.h"
#import "Historyillness.h"


@interface EntryInfoViewController ()

@property (nonatomic, strong) UIScrollView *InfoScrollView;


@property (nonatomic, assign) float Height;

@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation EntryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view addSubview:self.InfoScrollView];
//    self.view.backgroundColor = ThemeColor;

}

- (void)initView
{
     InfoHeadView *view = [[InfoHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1000)];
    view.backgroundColor = [UIColor clearColor];
    [self.InfoScrollView addSubview:view];
    
    self.Height = view.bounds.size.height;
    for (int i = 0; i < 3; i++) {
        Historyillness *historyview = [[Historyillness alloc] initWithFrame:CGRectMake(18, view.bounds.size.height + 50 + 510*i,ScreenWidth-18*2, 500)];
        historyview.layer.cornerRadius = 5.0f;
        historyview.layer.masksToBounds = YES;
        historyview.layer.borderWidth = 1.0f;
        historyview.layer.borderColor = RGBACG(234, 234, 234, 1);
        [_InfoScrollView addSubview:historyview];
        self.Height = _Height + (float)historyview.bounds.size.height;
    }
    NSLog(@"height--%f",self.Height);
    

    [self.sendBtn addTarget:self action:@selector(SendInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.InfoScrollView addSubview: self.sendBtn];
    
  
}


- (void)SendInfoAction
{
    KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = nil;
    [UIApplication sharedApplication].keyWindow.rootViewController = KKPTabVc;
}
- (UIScrollView *)InfoScrollView
{
//    _InfoScrollView.contentSize = CGSizeMake(ScreenWidth,self.Height);
    if (_InfoScrollView == nil) {
        _InfoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+20)];
        _InfoScrollView.backgroundColor = [UIColor whiteColor];
        _InfoScrollView.contentSize = CGSizeMake(ScreenWidth, 2500);
        _InfoScrollView.showsHorizontalScrollIndicator=NO;
        _InfoScrollView.showsVerticalScrollIndicator=NO;
    }
    return _InfoScrollView;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, self.Height + 100, ScreenWidth-18*2, 50)];
        _sendBtn.backgroundColor = ThemeColor;
        _sendBtn.layer.cornerRadius = 5.0f;
        _sendBtn.layer.masksToBounds = YES;
        [_sendBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    }
    return _sendBtn;
}
//- (EntryInfoView *)entryInfoView
//{
//    if (_entryInfoView == nil ) {
//        _entryInfoView = [[EntryInfoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 380)];
//    }
//    return _entryInfoView;
//}



@end
