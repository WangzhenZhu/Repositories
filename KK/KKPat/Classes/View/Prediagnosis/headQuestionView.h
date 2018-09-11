//
//  headQuestionView.h
//  KKPat
//
//  Created by Wang on 2018/9/10.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PreParamModel;
typedef void (^InputParamBlock)(PreParamModel *);

@interface headQuestionView : UIView


@property (nonatomic, copy) InputParamBlock inputParamBlock;

- (void)requestDataWithPatamBlock:(InputParamBlock)inputPatamBlock;
@end
