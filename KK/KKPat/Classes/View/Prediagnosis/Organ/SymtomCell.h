//
//  SymtomCell.h
//  KKPat
//
//  Created by Wang on 2018/9/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KKSymtomCellType){
    KKSymtomCellTypeBody,
    KKSymtomCellTypeSymtom
};

@interface SymtomCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) KKSymtomCellType cellType;
@property (nonatomic, assign) BOOL selectStatus;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(KKSymtomCellType)type;
@end
