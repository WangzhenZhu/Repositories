//
//  KKEditMedicalRecordViewController.m
//  KKMed
//
//  Created by Wang on 15/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKEditMedicalRecordViewController.h"
#import "Historyillness.h"
#import "KKConfiguration.h"
@interface KKEditMedicalRecordViewController ()

@property (nonatomic, strong) Historyillness *historyillView;

@property (nonatomic, strong) UIScrollView *editHistoryScroll;

@property (nonatomic, assign) float Height;
@end

@implementation KKEditMedicalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改病历";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self.view addSubview:self.editHistoryScroll];
    // Do any additional setup after loading the view.
}

- (void)initView
{

    for (int i = 0; i < 2; i++) {
        Historyillness *historyview = [[Historyillness alloc] initWithFrame:CGRectMake(18, self.Height + 50 ,ScreenWidth-18*2, 500)];
        historyview.layer.cornerRadius = 5.0f;
        historyview.layer.masksToBounds = YES;
        historyview.layer.borderWidth = 1.0f;
        historyview.layer.borderColor = RGBACG(234, 234, 234, 1);
       [self.editHistoryScroll addSubview:historyview];
        self.Height = _Height + (float)historyview.bounds.size.height + 50;
        NSLog(@"height--%f",self.Height);
    }

}
//- (Historyillness *)historyillView
//{
//    if (!_historyillView) {
//        _historyillView = [[Historyillness alloc] initWithFrame:CGRectMake(0,_Height, 34, 40)];
//    }
//    return _historyillView;
//}


- (UIScrollView *)editHistoryScroll
{
    if(!_editHistoryScroll)
    {
        _editHistoryScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _editHistoryScroll.contentSize = CGSizeMake(ScreenWidth, 1200);
        _editHistoryScroll.showsVerticalScrollIndicator = NO;
    }
    return _editHistoryScroll;
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
