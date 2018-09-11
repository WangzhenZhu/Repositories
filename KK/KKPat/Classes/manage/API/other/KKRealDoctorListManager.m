//
//  KKRealDoctorListManager.m
//  KKPat
//
//  Created by Wang on 25/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKRealDoctorListManager.h"

@implementation KKRealDoctorListManager

- (instancetype)init
{
    if ([super init]) {
        self.requestUrl = [NSString stringWithFormat:@"%@%@",[KKBaseUrlConfiguration currentConfiguration].baseUrl,@"/patient/listRealDoctor"];
        self.requestType = KKAPIManagerRequestTypePost;
    }
    return self;
}
@end
