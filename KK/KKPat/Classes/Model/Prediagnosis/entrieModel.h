//
//  entrieModel.h
//  KKPat
//
//  Created by Wang on 2018/9/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface entrieModel : NSObject

//(RSBP)最近收缩压、(USBP)通常收缩压、(RDBP)最近舒张压、(UDBP)通常舒张压、(DOS)症状持续时间、(GA)孕周
@property (nonatomic, strong) NSString *key;
//小问题
@property (nonatomic, strong) NSString *label;
//输入类型
@property (nonatomic, strong) NSString *valueType;
//输入默认值
@property (nonatomic, strong) NSNumber *value;

@end
