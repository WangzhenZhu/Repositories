//
//  TimeSelect.m
//  KKPat
//
//  Created by Wang on 12/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "TimeSelect.h"
#import "KKConfiguration.h"

@interface TimeSelect()

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *TimeDataPicker;

@property (nonatomic, strong) NSString *currentDateString;

@end

@implementation TimeSelect

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"TimeSelect" owner:nil options:nil].firstObject;
        self.frame = frame;

        self.TimeDataPicker.contentMode = UIDatePickerModeDate;
        self.TimeDataPicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.TimeDataPicker.calendar = [NSCalendar currentCalendar];
        [self.TimeDataPicker addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];
        [self.cancelBtn addTarget:self action:@selector(CancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.okBtn addTarget:self action:@selector(OkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)CancelAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissTimeSelect)]) {
        [self.delegate dismissTimeSelect];
    }
}
- (void)OkAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backDate:)]) {
        if (!self.currentDateString) {
            self.currentDateString = [self CurrentToDate];
        }
        [self.delegate backDate:self.currentDateString];
        
    }
}

- (void)getDate:(UIDatePicker *)TimePicker
{
    NSLog(@"----%@",TimePicker.date);
    self.currentDateString = [self NSStringToDate:TimePicker.date];

}

//将date转化为字符串
- (NSString *)NSStringToDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

//将当前日期转为字符串
- (NSString *)CurrentToDate
{
    NSDate *currentDate = [NSDate date];
    return [self NSStringToDate:currentDate];
}
@end
