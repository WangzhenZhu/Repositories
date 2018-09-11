//
//  KKPOrdersViewController.m
//  KKPat
//
//  Created by Wang on 21/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPOrdersViewController.h"
#import "KKPOrderedInfoViewController.h"
#import "KKPOrderingInfoViewController.h"
#import "KKConfiguration.h"
#import "OrderingCollectionCell.h"
#import "orderedCollectionCell.h"
#import "orderHeadView.h"

static NSString *OrderingCollectionCellID = @"OrderingCollectionCellID";
static NSString *orderedCollectionCellID = @"orderedCollectionCellID";

@interface KKPOrdersViewController ()<orderHeadViewDelegate,orderedCollectionCellDelegate,orderingCollectionCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) orderHeadView *headView;

@property (nonatomic, strong) UICollectionView *orderCollection;
@end

@implementation KKPOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.headView];
    [self.view addSubview: self.orderCollection];
    self.view.backgroundColor = [UIColor whiteColor];
   

}

- (void)viewWillAppear:(BOOL)animated
{
//    //去导航栏线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//
//    [self setHeadView];
     self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLayoutSubviews
{

    [self.orderCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark --UIcollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth, ScreenHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0 );
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OrderingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OrderingCollectionCellID forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else
    {
        orderedCollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:orderedCollectionCellID forIndexPath:indexPath];
        cell.delegate  = self;
        return cell;
    }
}


#pragma mark -- ScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat Width = _headView.sliderScroll.bounds.size.width;
    CGFloat OrginY = _headView.sliderScroll.frame.origin.y;
    self.headView.sliderScroll.frame = CGRectMake(5 + (Width/ScreenWidth)*scrollView.contentOffset.x, OrginY, Width, _headView.sliderScroll.bounds.size.height);
    self.headView.sliderScroll.contentOffset = CGPointMake((Width/ScreenWidth)*scrollView.contentOffset.x, 0);
}

#pragma mark --orderHeadViewDelegate
- (void)ScrollFollowWithLeftButton
{
    self.orderCollection.contentOffset = CGPointMake(0, 0);
}

- (void)ScrollFollowWithRightButton
{
    self.orderCollection.contentOffset = CGPointMake(ScreenWidth, 0);
}

#pragma mark --orderedCollectionCellDelegate
- (void)goToHistoryOrderInfo
{
    KKPOrderedInfoViewController *orderedInfoVc = [[KKPOrderedInfoViewController alloc] init];
    orderedInfoVc.title = @"订单详情";
    [self.navigationController pushViewController:orderedInfoVc animated:YES];
}
#pragma mark --orderingCollectionCellDelegate
- (void)goToOrderingInfo
{
    KKPOrderingInfoViewController *orderingInfoVc = [[KKPOrderingInfoViewController alloc] init];
    orderingInfoVc.title  = @" 正在进行的订单";
    [self.navigationController pushViewController:orderingInfoVc animated:YES];
}
- (UICollectionView *)orderCollection
{
    if (!_orderCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _orderCollection = [[UICollectionView alloc] initWithFrame:CGRectZero  collectionViewLayout:layout];
        _orderCollection.pagingEnabled = YES;
        _orderCollection.bounces = NO;
        _orderCollection.showsHorizontalScrollIndicator = NO;
        [_orderCollection setCollectionViewLayout:layout];
        [_orderCollection registerClass:[OrderingCollectionCell class] forCellWithReuseIdentifier:OrderingCollectionCellID];
        [_orderCollection registerClass:[orderedCollectionCell class] forCellWithReuseIdentifier:orderedCollectionCellID];
        _orderCollection.delegate = self;
        _orderCollection.dataSource = self;
    }
    return _orderCollection;
}

- (orderHeadView *)headView
{
    if (!_headView) {
        _headView = [[orderHeadView alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-10*2, 44)];
        _headView.delegate = self;
    }
    return _headView;
}

@end
