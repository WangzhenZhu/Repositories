//
//  KKEntryInfo.h
//  KKPat
//
//  Created by Wang on 22/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKEntryInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *id_num;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *pastMedicalHistory;
@property (nonatomic, strong) NSString *personalHistory;
@property (nonatomic, strong) NSString *menstrualHistory;
@property (nonatomic, strong) NSString *marriageHistory;
@property (nonatomic, strong) NSString *familyHistory;
@property (nonatomic, strong) NSString *allergy;

@end

