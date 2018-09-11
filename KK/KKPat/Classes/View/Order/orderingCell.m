//
//  orderingCell.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "orderingCell.h"
#import "KKConfiguration.h"
@interface orderingCell()

@property (weak, nonatomic) IBOutlet UIImageView *itemBg;


@end
@implementation orderingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
