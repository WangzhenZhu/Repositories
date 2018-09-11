//
//  doctorInfoView.h
//  KKPat
//
//  Created by Wang on 28/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doctorInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *sexLab;

@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *consultCountLab;

@property (weak, nonatomic) IBOutlet UIImageView *doctorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *specialityLab;

@property (weak, nonatomic) IBOutlet UILabel *departmentLab;
@property (weak, nonatomic) IBOutlet UILabel *categoryLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialityLabHeight;

@end
