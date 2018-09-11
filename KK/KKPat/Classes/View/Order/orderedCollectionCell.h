//
//  orderedCollectionCell.h
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol orderedCollectionCellDelegate <NSObject>

- (void)goToHistoryOrderInfo;

@end

@interface orderedCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<orderedCollectionCellDelegate> delegate;

@end
