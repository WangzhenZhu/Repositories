//
//  MeCell.m
//  KKPat
//
//  Created by Wang on 08/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "MeCell.h"

@interface MeCell()

@property (weak, nonatomic) IBOutlet UILabel *meLab;

@end
@implementation MeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshViewWithData:(NSString *)data
{
    self.meLab.text = data;
}
@end
