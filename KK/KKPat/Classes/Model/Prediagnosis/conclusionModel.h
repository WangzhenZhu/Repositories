//
//  conclusionModel.h
//  KKPat
//
//  Created by Wang on 2018/9/7.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface conclusionModel : NSObject
//行动类型，home：在家静养、nurse：咨询专业护士、hospital：医院、emergency：急救
@property (nonatomic, strong) NSString *actionType;
// 建议的采取行动的时间, 例如24小时内
@property (nonatomic, strong) NSString *actionTime;
 // 建议采取行动
@property (nonatomic, strong) NSString *actionLabel;
// 紧急程度（最高紧急程度为1）
@property (nonatomic, strong) NSString *emergencyLevel;
// 建议挂号科室
@property (nonatomic, strong) NSString *departInfo;
// 结论描述
@property (nonatomic, strong) NSString *content;
// 补充建议
@property (nonatomic, strong) NSString *suggets;

@end
