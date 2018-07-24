//
//  Historyillness.m
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "Historyillness.h"
#import "SicknessNameCell.h"
#import "KKConfiguration.h"
static NSString *SicknessNameCellID = @"SicknessNameCellID";
@interface Historyillness()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic)  UILabel *HistoryillnessLab;

@property (strong, nonatomic)  UITableView *HistoryillnessTableView;

@property (strong, nonatomic) UILabel *HistoryLine;
@property (nonatomic, strong) NSArray *illnessNameArr;
@end
@implementation Historyillness

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.illnessNameArr = @[@"高血压",@"冠心病",@"肝炎",@"手术",@"外伤",@"过敏",@"血制品输入",@"过敏"];
        [self addSubview:self.HistoryillnessLab];
        [self addSubview:self.HistoryLine];
        [self addSubview:self.HistoryillnessTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.HistoryillnessLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(10);
        make.left.equalTo(self.mas_left).mas_offset(18);
        make.right.equalTo(self.mas_right).mas_offset(-18);
        make.height.equalTo(@20);
    }];
    [self.HistoryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.HistoryillnessLab.mas_bottom).mas_offset(10);
        make.left.equalTo(self.mas_left).mas_offset(18);
        make.right.equalTo(self.mas_right).mas_offset(-18);
        make.height.equalTo(@1);
    }];
    [self.HistoryillnessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.HistoryLine.mas_bottom).mas_offset(100);
        make.left.equalTo(self.HistoryLine.mas_left);
        make.right.equalTo(self.HistoryLine.mas_right);
        make.height.equalTo(@200);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _illnessNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SicknessNameCell *cell = [tableView dequeueReusableCellWithIdentifier:SicknessNameCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SicknessNameCell" owner:nil options:nil] firstObject];
    }
    [cell refershViewWithData:_illnessNameArr[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGRect frame = self.HistoryillnessTableView.frame;
    frame.size = self.HistoryillnessTableView.contentSize;
    self.HistoryillnessTableView.frame = frame;
    
//    CGRect selfFrame = self.frame;
//    selfFrame.size.height = self.HistoryillnessTableView.
}

- (UITableView *)HistoryillnessTableView
{
    if (!_HistoryillnessTableView) {
        _HistoryillnessTableView = [[UITableView alloc] init];
//        _HistoryillnessTableView.layer.cornerRadius = 10.f;
//        _HistoryillnessTableView.layer.masksToBounds = YES;
        _HistoryillnessTableView.delegate = self;
        _HistoryillnessTableView.dataSource = self;
//        _HistoryillnessTableView.backgroundColor = [UIColor redColor];
//        _HistoryillnessTableView.backgroundColor = [UIColor clearColor];
        _HistoryillnessTableView.separatorStyle = NO;
        [_HistoryillnessTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    }
    return _HistoryillnessTableView;
}

- (UILabel *)HistoryillnessLab
{
    if (!_HistoryillnessLab) {
        _HistoryillnessLab = [[UILabel alloc] init];
        _HistoryillnessLab.text = @"既往史";
        _HistoryillnessLab.font = [UIFont systemFontOfSize:23];
        
        [_HistoryillnessLab setBackgroundColor:[UIColor clearColor]];
        [_HistoryillnessLab sizeToFit];
        [_HistoryillnessLab setTextColor:ThemeColor];
        _HistoryillnessLab.textAlignment = NSTextAlignmentCenter;
    }
    return _HistoryillnessLab;
}

- (UILabel *)HistoryLine
{
    if (!_HistoryLine) {
        _HistoryLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _HistoryLine.backgroundColor = RGB(229, 229, 229);
    }
    return _HistoryLine;
}

@end
