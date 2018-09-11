//
//  KKEntryInfoManager.m
//  KKPat
//
//  Created by Wang on 22/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKEntryInfoManager.h"

@implementation KKEntryInfoManager

- (instancetype)init
{
    if ([super init]) {
        self.requestUrl = [NSString stringWithFormat:@"%@%@",[KKBaseUrlConfiguration currentConfiguration].baseUrl,@"/api/patient/newPatientInfo"];
        self.requestType = KKAPIManagerRequestTypePost;
    }
    return self;
}

@end
