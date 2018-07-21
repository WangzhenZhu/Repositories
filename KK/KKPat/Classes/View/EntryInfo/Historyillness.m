//
//  Historyillness.m
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "Historyillness.h"
#import "SicknessNameCell.h"

static NSString *SicknessNameCellID = @"SicknessNameCellID";
@interface Historyillness()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *HistoryillnessLab;

@property (weak, nonatomic) IBOutlet UITableView *HistoryillnessTableView;

@property (nonatomic, strong) NSArray *illnessNameArr;
@end
@implementation Historyillness

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"lllll---%f",frame.origin.y);
        self = [[[NSBundle mainBundle] loadNibNamed:@"Historyillness" owner:nil options:nil] firstObject];
        self.frame = frame;
        self.HistoryillnessTableView.layer.cornerRadius = 10.f;
        self.HistoryillnessTableView.layer.masksToBounds = YES;
        self.HistoryillnessTableView.delegate = self;
        self.HistoryillnessTableView.dataSource = self;
        self.HistoryillnessTableView.backgroundColor = [UIColor clearColor];
        self.HistoryillnessTableView.separatorStyle = NO;
        self.illnessNameArr = @[@"高血压",@"冠心病",@"肝炎",@"手术",@"外伤",@"过敏",@"血制品输入",@"过敏"];
        [self.HistoryillnessTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    
    }
    return self;
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
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
