//
//  OrganListViewController.m
//  KKPat
//
//  Created by Wang on 2018/9/2.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "OrganListViewController.h"
#import "KKConfiguration.h"
#import "SymtomCell.h"
#import "consultViewController.h"
static NSString *bodyCellID = @"BodyCellID";
static NSString *symtomCellID = @"SymtomCellID";

@interface OrganListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *bodyTableView;

@property (nonatomic, strong) UITableView *symtomTableView;

@property (nonatomic, strong) NSMutableArray *PrediaArr;
@end

@implementation OrganListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"预 诊";
        [self.view addSubview:self.bodyTableView];
        [self.view addSubview:self.symtomTableView];
//        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
   
}


#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.bodyTableView]) {
        return self.PrediaArr.count;
    }
    if ([tableView isEqual:self.symtomTableView]) {
        return [self symtomListWithIndex:self.selectIndexPath.section].count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.bodyTableView]) {
        SymtomCell *cell = [tableView dequeueReusableCellWithIdentifier:bodyCellID];
        if (!cell) {
            cell = [[SymtomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bodyCellID type:KKSymtomCellTypeBody];
        }
//        if (indexPath.row == 0) {
        
//            cell.backgroundColor = ThemeColor;
//            cell.textLabel.textColor = [UIColor whiteColor];
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = [self.PrediaArr[indexPath.row] objectForKey:@"body"];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if (indexPath.row == self.selectIndexPath.section) {
            [cell setSelectStatus:YES];
        }else
        {
            [cell setSelectStatus:NO];
        }
        return cell;
    }else if ([tableView isEqual:self.symtomTableView])
    {
        SymtomCell *cell = [tableView dequeueReusableCellWithIdentifier:symtomCellID];
        if (!cell) {
            cell = [[SymtomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:symtomCellID type:KKSymtomCellTypeSymtom];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        NSArray *symtomList = [self symtomListWithIndex:self.selectIndexPath.section];
        if (symtomList) {
            cell.title = [[symtomList objectAtIndex:indexPath.row] objectForKey:@"symptom"];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.bodyTableView]) {
        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        
    }else if ([tableView isEqual:self.symtomTableView])
    {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:self.selectIndexPath.section];
        self.selectIndexPath = newIndexPath;
        consultViewController *consultVc = [[consultViewController alloc] init];
        [self.navigationController pushViewController:consultVc animated:YES];
    }
    [self reloadData];
}
- (void)reloadData
{
    [self.bodyTableView reloadData];
    [self.symtomTableView reloadData];
}
- (NSArray *)symtomListWithIndex:(NSInteger)index
{
    if (self.PrediaArr) {
        if (index < self.PrediaArr.count) {
            return [self.PrediaArr[index] objectForKey:@"symptomArr"];
        }
    }
    return nil;
}

- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath {
    if (selectIndexPath) {
        if (!(_selectIndexPath.section == selectIndexPath.section && _selectIndexPath.row == selectIndexPath.row)) {
            _selectIndexPath = selectIndexPath;
            [self.bodyTableView reloadData];
            [self.symtomTableView reloadData];
        }
    }
}

- (UITableView *)bodyTableView
{
    if (!_bodyTableView) {
        _bodyTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, 150, ScreenHeight)) style:UITableViewStylePlain];
        _bodyTableView.showsVerticalScrollIndicator = NO;
        [_bodyTableView setSeparatorStyle:NO];
        _bodyTableView.bounces = NO;
//        _bodyTableView.backgroundColor = [UIColor grayColor];
        _bodyTableView.delegate = self;
        _bodyTableView.dataSource = self;
        
    }
    return _bodyTableView;
}

- (UITableView *)symtomTableView
{
    if (!_symtomTableView) {
        _symtomTableView = [[UITableView alloc] initWithFrame:CGRectMake(150, 64, ScreenWidth-150, ScreenHeight-64) style:UITableViewStylePlain];
        _symtomTableView.showsVerticalScrollIndicator = NO;
        _symtomTableView.backgroundColor = [UIColor whiteColor];
        [_symtomTableView setSeparatorStyle:NO];
        _symtomTableView.delegate = self;
        _symtomTableView.dataSource = self;
    }
    return _symtomTableView;
}
- (NSMutableArray *)PrediaArr
{
    if (!_PrediaArr) {
        _PrediaArr = [NSMutableArray array];
        NSString *path=[NSString stringWithFormat:@"%@/Documents/PrediagnosisList.plist",NSHomeDirectory()];
        _PrediaArr = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _PrediaArr;
}

@end
