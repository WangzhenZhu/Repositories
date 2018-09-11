//
//  questionModel.h
//  KKPat
//
//  Created by Wang on 2018/9/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class entrieModel,answersModel,conclusionModel;

@interface questionModel : NSObject <NSCoding>

//问题或结论
@property (nonatomic, strong) NSNumber *nodeType;

//问题ID
@property (nonatomic, strong) NSNumber *questionId;

//问题类型
@property (nonatomic, strong) NSNumber *questionType;
//问题内容
@property (nonatomic, strong) NSString *questionText;
//选择题数组
@property (nonatomic, strong) NSArray <answersModel *> *answers;
////输入项数组
//@property (nonatomic, strong) NSArray <entrieModel *> *entries;

//结论数组
@property (nonatomic, strong) NSArray <conclusionModel *> *conclusions;
//@property (nonatomic, strong) NSString *fillInContent;

@end
