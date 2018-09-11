//
//  MedicalRecordsView.m
//  KKPat
//
//  Created by Wang on 14/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "MedicalRecordsView.h"
#import "KKConfiguration.h"
@implementation MedicalRecordsView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MedicalRecordsView" owner:nil options:nil].firstObject;
        self.frame = frame;
        self.layer.cornerRadius = 8.f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = RGBACG(150, 150, 150, 0.3);
    }
    return self;
}
@end
