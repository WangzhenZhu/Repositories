//
//  loginOutCell.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "loginOutCell.h"

@interface loginOutCell()

@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

@end
@implementation loginOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logOutBtn.layer.cornerRadius = self.logOutBtn.bounds.size.height / 2;
    self.logOutBtn.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
