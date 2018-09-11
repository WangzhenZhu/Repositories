//
//  valueEntryCell.h
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class questionModel,answersModel;

@protocol valueEntryDelegate <NSObject>

- (void)okWithAnswer:(answersModel *)answersModel;

@end

@interface valueEntryCell : UITableViewCell

@property (nonatomic, weak) id <valueEntryDelegate> delegate;

- (void)refreshStyleWithData:(questionModel *)questionModel;
@end
