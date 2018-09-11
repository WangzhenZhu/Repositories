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

@property (weak, nonatomic) IBOutlet UIButton *SelectBtn;

@end
@implementation SicknessNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self.SelectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)selectAction
{
    self.SelectBtn.selected = !self.SelectBtn.selected;
}
- (void)refershViewWithData:(NSString *)Data
{
    self.SicknessNameLab.text = Data;
}

@end
