//
//  RealTimeDoctorCell.m
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "RealTimeDoctorCell.h"
#import "realDoctorModel.h"
#import "KKConfiguration.h"
@interface RealTimeDoctorCell()

@property (weak, nonatomic) IBOutlet UIImageView *doctorImageView;

@property (weak, nonatomic) IBOutlet UILabel *doctorNameLab;
@property (weak, nonatomic) IBOutlet UILabel *departmentLab;
@property (weak, nonatomic) IBOutlet UILabel *categoryLab;
@property (weak, nonatomic) IBOutlet UIImageView *onlineIcon;
@property (weak, nonatomic) IBOutlet UIImageView *offlineIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onlineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onlineOfflineGap;

@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *consultiveNumLab;
@property (weak, nonatomic) IBOutlet UILabel *specialityLab;

@property (weak, nonatomic) IBOutlet UIButton *sendRequestBtn;

@end
@implementation RealTimeDoctorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.sendRequestBtn addTarget:self action:@selector(SendRequestAction:) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)SendRequestAction:(UIButton *)sender
{
    self.sendRequestBtn.selected = !self.sendRequestBtn.selected;
}

- (void)refreshViewWithData:(realDoctorModel *)realDoctors
{
    self.doctorNameLab.text = realDoctors.name;
    NSString *Image =  [NSString stringWithFormat:@"%@",realDoctors.photo];
    
    [self.doctorImageView sd_setImageWithURL:[NSURL URLWithString:Image] placeholderImage:IMG(@"")];
    self.departmentLab.text = realDoctors.department;
    self.categoryLab.text = realDoctors.category;
    self.specialityLab.text = realDoctors.speciality;
    self.consultiveNumLab.text = [NSString stringWithFormat:@"已咨询%ld次",[realDoctors.consultCount integerValue]];
    if ([realDoctors.style integerValue] == 1) {
        self.offlineIcon.hidden = YES;
    } else if ([realDoctors.style integerValue] == 2)
    {
        self.onlineWidth.constant = 0;
        self.onlineOfflineGap.constant = 0;
    } else {
        
    }
}

@end
