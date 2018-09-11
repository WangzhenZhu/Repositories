//
//  RealTimeDoctorCell.h
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class realDoctorModel;

@interface RealTimeDoctorCell : UITableViewCell

- (void)refreshViewWithData:(realDoctorModel *)realDoctors;
@end
