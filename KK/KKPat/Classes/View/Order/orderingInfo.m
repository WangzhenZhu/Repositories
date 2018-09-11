//
//  orderingInfo.m
//  KKPat
//
//  Created by Wang on 09/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "orderingInfo.h"
#import "KKConfiguration.h"
@interface orderingInfo()
@property (weak, nonatomic) IBOutlet UIView *modeView;
@property (weak, nonatomic) IBOutlet UIView *waitOkView;
@property (weak, nonatomic) IBOutlet UIView *TimeAndPlaceView;
@property (weak, nonatomic) IBOutlet UIView *WaitStartTimingView;



@end

@implementation orderingInfo

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"orderingInfo" owner:nil options:nil] firstObject];
        self.frame = frame;
        self.modeView.layer.borderWidth = 1.f;
        self.modeView.layer.borderColor = ThemeColorACG;
        self.modeView.layer.cornerRadius = 5.f;
        self.modeView.layer.masksToBounds = YES;
        
        self.waitOkView.layer.borderWidth = 1.f;
        self.waitOkView.layer.borderColor = ThemeColorACG;
        self.waitOkView.layer.cornerRadius = 5.f;
        self.waitOkView.layer.masksToBounds = YES;
        
        self.TimeAndPlaceView.layer.borderWidth = 1.f;
        self.TimeAndPlaceView.layer.borderColor = ThemeColorACG;
        self.TimeAndPlaceView.layer.cornerRadius = 5.f;
        self.TimeAndPlaceView.layer.masksToBounds = YES;
        
        self.WaitStartTimingView.layer.borderWidth = 1.f;
        self.WaitStartTimingView.layer.borderColor = ThemeColorACG;
        self.WaitStartTimingView.layer.cornerRadius = 5.f;
        self.WaitStartTimingView.layer.masksToBounds = YES;
        
        
    }
    return self;
}
@end
