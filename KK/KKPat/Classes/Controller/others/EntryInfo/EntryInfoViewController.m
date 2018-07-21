//
//  EntryInfoViewController.m
//  KKPat
//
//  Created by Wang on 17/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "EntryInfoViewController.h"
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
    self.view.backgroundColor = ThemeColor;

}

- (void)initView
{
     InfoHeadView *view = [[InfoHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1000)];
    [self.InfoScrollView addSubview:view];
    self.Height = view.bounds.size.height;
    for (int i = 1; i < 4; i++) {
        Historyillness *historyview = [[Historyillness alloc] initWithFrame:CGRectMake(0, i * view.bounds.size.height,ScreenWidth, 1000)];
        [_InfoScrollView addSubview:historyview];
        self.Height = _Height + (float)historyview.bounds.size.height;
    }
    NSLog(@"height--%f",self.Height);
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.Height + 20, ScreenWidth, 40)];
    [self.sendBtn addTarget:self action:@selector(SendInfoAction) forControlEvents:UIControlEventTouchUpInside];
    
  
}


- (void)SendInfoAction
{
    
}
- (UIScrollView *)InfoScrollView
{
    _InfoScrollView.contentSize = CGSizeMake(ScreenWidth,self.Height);
    if (_InfoScrollView == nil) {
        _InfoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20)];
        
        _InfoScrollView.showsHorizontalScrollIndicator=NO;
        _InfoScrollView.showsVerticalScrollIndicator=NO;
    }
    return _InfoScrollView;
}
//- (EntryInfoView *)entryInfoView
//{
//    if (_entryInfoView == nil ) {
//        _entryInfoView = [[EntryInfoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 380)];
//    }
//    return _entryInfoView;
//}



@end
