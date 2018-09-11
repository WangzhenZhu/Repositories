//
//  reservationCell.m
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "reservationCell.h"

@interface reservationCell()

@property (weak, nonatomic) IBOutlet UIButton *sendRequestBtn;
@end
@implementation reservationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.sendRequestBtn addTarget:self action:@selector(sendRequestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // Initialization code
}

- (void)sendRequestAction:(UIButton *)sender
{
    self.sendRequestBtn.selected = !self.sendRequestBtn.selected;
}

@end
