//
//  OrderingCollectionCell.m
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "OrderingCollectionCell.h"
#import "orderingCell.h"
#import "KKConfiguration.h"

static NSString *orderingCellID = @"orderingCellID";
@interface OrderingCollectionCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *OrderingTableView;

@end

@implementation OrderingCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.OrderingTableView];
    }
    return self;
}


- (void)layoutSubviews
{
    [self.OrderingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-49);
    }];
}
#pragma mark --TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 247.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderingCell *cell = [tableView dequeueReusableCellWithIdentifier:orderingCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"orderingCell" owner:nil options:nil] firstObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(goToOrderingInfo)]) {
        [_delegate goToOrderingInfo];
    }
}

- (UITableView *)OrderingTableView
{
    if (!_OrderingTableView) {
        _OrderingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _OrderingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _OrderingTableView.showsVerticalScrollIndicator = NO;
        _OrderingTableView.delegate = self;
        _OrderingTableView.dataSource = self;
    }
    return _OrderingTableView;
}
@end
