//
//  answerCell.h
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class answersModel;

@interface answerCell : UITableViewCell

- (void)refreshViewWithModel:(answersModel *)answerModel;
@end
