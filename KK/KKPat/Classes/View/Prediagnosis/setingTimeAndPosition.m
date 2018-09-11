//
//  setingTimeAndPosition.m
//  KKMed
//
//  Created by Wang on 12/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "setingTimeAndPosition.h"
#import "KKConfiguration.h"
#import "AMapViewController.h"
@interface setingTimeAndPosition()
@property (weak, nonatomic) IBOutlet UIView *setTimeView;

@property (weak, nonatomic) IBOutlet UIView *setPosition;


@property (weak, nonatomic) IBOutlet UIView *SettingPlaceView;

@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@end
@implementation setingTimeAndPosition

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"setingTimeAndPosition" owner:nil options:nil] firstObject];
        self.frame = frame;
        self.setTimeView.layer.borderWidth = 1.0f;
        self.setTimeView.layer.borderColor = RGBACG(150, 150, 150, 1);
        self.setTimeView.layer.cornerRadius = 8.0f;
        self.setTimeView.layer.masksToBounds = YES;
        
        self.setPosition.layer.borderWidth = 1.0f;
        self.setPosition.layer.borderColor = RGBACG(150, 150, 150, 1);
        self.setPosition.layer.cornerRadius = 8.0f;
        self.setPosition.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToMap)];
        [self.SettingPlaceView addGestureRecognizer:tapView];
        
    }
    return self;
}

- (void)goToMap
{
    AMapViewController *AmapVc = [[AMapViewController alloc] init];
    AmapVc.BackSlect = ^(CLLocationCoordinate2D coordinate, NSString *addressName) {
        self.addressLab.text = addressName;
    };
    [[self viewController].navigationController pushViewController:AmapVc animated:YES];
}

- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
