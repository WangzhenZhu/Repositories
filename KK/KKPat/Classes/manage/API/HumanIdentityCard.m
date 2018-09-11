//
//  HumanIdentityCard.m
//  KKPat
//
//  Created by Wang on 31/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "HumanIdentityCard.h"
#import "KKConfiguration.h"
@implementation HumanIdentityCard

- (instancetype)init
{
    if ([super init]) {
        self.requestUrl = KKHUMANID_API;
        self.requestType = KKAPIManagerRequestTypePost;

    }
    return self;
}

- (NSDictionary *)reformHeaderParams
{
    return @{@"Authorization":ALI_APPCODE,@"Content-Type":@"application/x-www-form-urlencoded; charset=UTF-8"};
}
@end
