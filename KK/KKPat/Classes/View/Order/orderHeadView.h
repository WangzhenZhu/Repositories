//
//  orderHeadView.h
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol orderHeadViewDelegate <NSObject>

- (void)ScrollFollowWithLeftButton;
- (void)ScrollFollowWithRightButton;

@end

@interface orderHeadView : UIView

@property (nonatomic, strong) UIScrollView *sliderScroll;

@property (nonatomic, weak) id<orderHeadViewDelegate> delegate;

@end
