//
//  InfoHeadView.m
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "InfoHeadView.h"
#import "KKConfiguration.h"
@interface InfoHeadView()

@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (weak, nonatomic) IBOutlet UIView *baseBgView;

@property (weak, nonatomic) IBOutlet UIView *IDCardBgView;
@end
@implementation InfoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"InfoHeadView" owner:nil options:nil] firstObject];
        self.baseBgView.layer.cornerRadius = 5.0f;
        self.baseBgView.layer.masksToBounds = YES;
        self.baseBgView.layer.borderWidth = 1.0f;
        self.baseBgView.layer.borderColor = RGBACG(234, 234, 234, 1);
        self.IDCardBgView.layer.cornerRadius = 5.0f;
        self.IDCardBgView.layer.masksToBounds = YES;
        self.IDCardBgView.layer.borderWidth = 1.0f;
        self.IDCardBgView.layer.borderColor = RGBACG(234, 234, 234, 1);
        
      
    }
    return self;
}


@end
