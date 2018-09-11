//
//  KKLoginManager.m
//  KKPat
//
//  Created by Wang on 21/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKLoginManager.h"

@implementation KKLoginManager

- (instancetype)init
{
    if ([super init]) {
        self.requestUrl = [NSString stringWithFormat:@"%@%@",[KKBaseUrlConfiguration currentConfiguration].baseUrl,@"/api/patient/register"];
        self.requestType = KKAPIManagerRequestTypePost;
    }
    return self;
}


@end
