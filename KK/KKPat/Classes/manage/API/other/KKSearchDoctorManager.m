//
//  KKSearchDoctorManager.m
//  KKPat
//
//  Created by Wang on 26/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKSearchDoctorManager.h"

@implementation KKSearchDoctorManager

- (instancetype)init
{
    if ([super init]) {
        self.requestUrl = [NSString stringWithFormat:@"%@%@",[KKBaseUrlConfiguration currentConfiguration].baseUrl,@"/patient/listDoctorByName"];
        self.requestType = KKAPIManagerRequestTypePost;
    }
    return self;
}
@end
