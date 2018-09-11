//
//  SetingTimeAndPositionViewController.m
//  KKMed
//
//  Created by Wang on 12/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "SetingTimeAndPositionViewController.h"
#import "setingTimeAndPosition.h"
#import "TimeSelect.h"
#import "KKConfiguration.h"


@interface SetingTimeAndPositionViewController ()<TimeSelectDelegate>

@property (nonatomic, strong) setingTimeAndPosition *setView;

@property (nonatomic, strong) CNPPopupController *popupController;

@property (nonatomic, assign) BOOL IsStartAndEnd;

@property (nonatomic, strong) TimeSelect *timeSelectView;

@end

@implementation SetingTimeAndPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.setView];
     
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (setingTimeAndPosition *)setView
{
    if (!_setView) {
        _setView = [[setingTimeAndPosition alloc] initWithFrame:self.view.frame];
        _setView.startTimeBtn.tag = 2001;
        _setView.endTimeBtn.tag = 2002;
        [_setView.startTimeBtn addTarget:self action:@selector(popTimeSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_setView.endTimeBtn addTarget:self action:@selector(popTimeSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setView;
}

- (void)popTimeSelect:(UIButton *)sender
{
    if (sender.tag == 2001) {
        self.IsStartAndEnd = YES;
    }else
    {
        self.IsStartAndEnd = NO;
    }
    TimeSelect *timeSelect = [[TimeSelect alloc] init];
    [timeSelect setFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    timeSelect.delegate = self;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[timeSelect]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.popupContentInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [self.popupController presentPopupControllerAnimated:YES];

}

#pragma mark - TimeSelectDelegate
- (void)dismissTimeSelect
{
    [self.popupController dismissPopupControllerAnimated:YES];
}
- (void)backDate:(NSString *)date
{
    if (_IsStartAndEnd) {
         self.setView.startTimeLab.text = date;
    }else{
        self.setView.endTimeLab.text = date;
    }
    [self.popupController dismissPopupControllerAnimated:YES];
}
- (TimeSelect *)timeSelectView
{
    if (!_timeSelectView) {
     _timeSelectView = [[TimeSelect alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    }
    return _timeSelectView;
}


@end
