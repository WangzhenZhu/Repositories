//
//  orderedCollectionCell.m
//  KKPat
//
//  Created by Wang on 25/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "orderedCollectionCell.h"
#import "orderedCell.h"
#import "KKConfiguration.h"
static NSString *orderedCellID = @"orderedCellID";

@interface orderedCollectionCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *OrderedTableView;

@end
@implementation orderedCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor brownColor];
        self.OrderedTableView.delegate = self;
        self.OrderedTableView.dataSource = self;
        [self.contentView addSubview:self.OrderedTableView];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [self.OrderedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.bottom.equalTo(self.mas_bottom);
//    }];
//}
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
    return 102.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderedCell *cell = [tableView dequeueReusableCellWithIdentifier:orderedCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"orderedCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(goToHistoryOrderInfo)]) {
        [_delegate goToHistoryOrderInfo];
    }
}

- (UITableView *)OrderedTableView
{
    if (!_OrderedTableView) {
        _OrderedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
      
        _OrderedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
    }
    return _OrderedTableView;
}
@end
