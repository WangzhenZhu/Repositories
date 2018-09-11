//
//  singleSelectionCell.h
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class questionModel,answersModel;

@protocol singleSelectionDelegate <NSObject>

- (void)choosedAction:(answersModel *)choosedAnswer withSelected:(int )selectedId;
@end

@interface singleSelectionCell : UITableViewCell

@property (nonatomic, weak) id <singleSelectionDelegate> delegate;

- (void)refreshStyleWithModel:(questionModel *)questionModel withSelectedId:(NSNumber *)selectId;

@end
