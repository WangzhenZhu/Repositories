//
//  PreParamModel.h
//  KKPat
//
//  Created by Wang on 2018/9/10.
//  Copyright © 2018年 Wang. All rights reserved.
// 预诊的请求参数

#import <Foundation/Foundation.h>

@interface PreParamModel : NSObject

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSNumber *height;
//1: 男性 2: 女性
@property (nonatomic, strong) NSNumber *sex;

@property (nonatomic, strong) NSString *symptomId;

@property (nonatomic, strong) NSNumber *weight;

@end
