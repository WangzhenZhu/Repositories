//
//  TimeSelect.h
//  KKPat
//
//  Created by Wang on 12/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TimeSelectDelegate <NSObject>

- (void)dismissTimeSelect;

- (void)backDate:(NSString *)date;
@end

@interface TimeSelect : UIView

@property (nonatomic, weak) id<TimeSelectDelegate> delegate;

- (NSString *)CurrentToDate;

@end
