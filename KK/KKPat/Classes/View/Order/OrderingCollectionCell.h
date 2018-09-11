//
//  OrderingCollectionCell.h
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol orderingCollectionCellDelegate <NSObject>

- (void)goToOrderingInfo;

@end

@interface OrderingCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<orderingCollectionCellDelegate> delegate;
@end
