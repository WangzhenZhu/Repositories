//
//  KKFetchQuestionManager.m
//  KKPat
//
//  Created by Wang on 2018/9/10.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "KKFetchQuestionManager.h"
#import "KKConfiguration.h"
@implementation KKFetchQuestionManager

- (instancetype)init
{
    if (self = [super init]) {
        self.requestUrl = [NSString stringWithFormat:@"%@/fetchQuestion",KKPREDIAGNOSIS_API];
        self.requestType = KKAPIManagerRequestTypePost;
    }
    return self;
}

- (NSDictionary *)reformHeaderParams
{
    return @{@"Authorization":ALI_APPCODE,@"Content-Type":@"application/x-www-form-urlencoded; charset=UTF-8"};
}
@end
