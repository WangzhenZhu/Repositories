//
//  realDoctorModel.h
//  KKPat
//
//  Created by Wang on 24/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface realDoctorModel : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *sex;

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSString *idNum;

@property (nonatomic, strong) NSString *photo;

@property (nonatomic, strong) NSString *diplomaImg;

@property (nonatomic, strong) NSNumber *diplomaNum;

@property (nonatomic, strong) NSString *hospital;

@property (nonatomic, strong) NSString *department;

@property (nonatomic, strong) NSString *speciality;

@property (nonatomic, strong) NSString *titleImg;

@property (nonatomic, strong) NSString *titleNum;

@property (nonatomic, strong) NSNumber *consultCount;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *idImg;

@property (nonatomic, strong) NSString *diploma;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSNumber *level;

@property (nonatomic, strong) NSString *isChecked;

@property (nonatomic, strong) NSNumber *style;

@end
