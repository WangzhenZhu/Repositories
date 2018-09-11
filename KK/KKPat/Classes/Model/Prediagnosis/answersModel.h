//
//  answersModel.h
//  KKPat
//
//  Created by Wang on 2018/9/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "entrieModel.h"

//@class entrieModel;
@interface answersModel : NSObject

@property (nonatomic, strong) NSNumber *questionId;
//选择题
@property (nonatomic, strong) NSNumber *answerId;

@property (nonatomic, strong) NSString *answerText;
//输入题
@property (nonatomic, strong) entrieModel *entriersModel;
@end
