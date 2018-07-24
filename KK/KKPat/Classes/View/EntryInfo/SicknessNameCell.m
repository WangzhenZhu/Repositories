//
//  SicknessNameCell.m
//  KKPat
//
//  Created by Wang on 20/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "SicknessNameCell.h"

@interface SicknessNameCell()

@property (weak, nonatomic) IBOutlet UIView *SicknessNameBg;

@property (weak, nonatomic) IBOutlet UILabel *SicknessNameLab;

@end
@implementation SicknessNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    // Initialization code
}

- (void)refershViewWithData:(NSString *)Data
{
    self.SicknessNameLab.text = Data;
}

@end
