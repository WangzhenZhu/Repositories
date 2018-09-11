//
//  consultViewController.m
//  KKPat
//
//  Created by Wang on 2018/9/4.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "consultViewController.h"
#import "KKConfiguration.h"

#import "singleSelectionCell.h"
#import "multiSelectionCell.h"
#import "valueEntryCell.h"
#import "answerCell.h"
#import "headQuestionView.h"

#import "questionModel.h"
#import "answersModel.h"
#import "entrieModel.h"
#import "PreParamModel.h"

static NSString *SingleSelectionCellID = @"SingleSelectionCellID";
static NSString *multiSelectionCellID = @"multiSelectionCellID";
static NSString *valueEntryCellID = @"valueEntryCellID";
static NSString *AnswerCellID = @"AnswerCellID";

@interface consultViewController ()<UITableViewDelegate, UITableViewDataSource,singleSelectionDelegate,valueEntryDelegate>

@property (nonatomic, strong) UITableView *ConsultTableView;

@property (nonatomic, strong) headQuestionView *headView;

@property (nonatomic, strong) NSMutableArray *questionArr;

@property (nonatomic, strong) NSMutableArray  *answerArr;

@property (nonatomic, strong) questionModel *questModel;

@property (nonatomic, strong) answersModel *answerModel;

@property (nonatomic, strong) NSMutableArray *SingleSelectedArr;

@property (nonatomic, strong) NSArray *questionPlistArr;


@end

@implementation consultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ConsultTableView];
    self.title = @"智能咨询";
    
}

//- (void)initData
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"plist"];
//    self.questionPlistArr =  [[NSArray alloc] initWithContentsOfFile:path];
//    [self addDataWithArray];
//}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.questionArr.count + self.answerArr.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 365;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //偶数为问题
    if (indexPath.row % 2 == 0) {
         NSUInteger row = indexPath.row / 2;
         
         self.questModel =  [questionModel yy_modelWithDictionary:self.questionArr[row]];
        //判断问题的类型 0:单选。1:多选。2:用户填写
        if ([self.questModel.questionType integerValue] == 0) {
            singleSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:SingleSelectionCellID];
            if (!cell) {
                cell = [[singleSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingleSelectionCellID];
                cell.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //判断是否被选。问题和答案数据 一一对应的
            if (row < _answerArr.count) {
                [cell refreshStyleWithModel:self.questModel withSelectedId:self.SingleSelectedArr[row]];
            }else
            {
                [cell refreshStyleWithModel:self.questModel withSelectedId:nil];
            }
            return cell;
        }
        //多选
        if ([self.questModel.questionType integerValue] == 1) {
            multiSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:multiSelectionCellID];
            if (!cell) {
                cell = [[multiSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:multiSelectionCellID];
            }
            return cell;
        }
        //用户填写
        if ([self.questModel.questionType integerValue] == 2) {
            valueEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:valueEntryCellID];
            if (!cell) {
                cell = [[valueEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:valueEntryCellID];
                cell.delegate = self;
            }
            [cell refreshStyleWithData:self.questModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    //奇数为答案
    }else if (indexPath.row % 2 != 0) {
        answerCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerCellID];
        if (!cell) {
            cell = [[answerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerCellID];
        }
        NSUInteger row = (indexPath.row - 1) / 2;

            answersModel *answerModel = [answersModel yy_modelWithDictionary:_answerArr[row]];
            [cell refreshViewWithModel:answerModel];
       
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark --singleSelectionDelegate
//- (void)choosedAction:(answersModel *)choosedAnswer withSelected:(int)selectedId
//{
//    //答案数组
//    [self.answerArr addObject:choosedAnswer];
//    //选择答案序号，用于展示
//    [self.SingleSelectedArr addObject:@(selectedId)];
//    [self addDataWithArray];
//    [self.ConsultTableView reloadData];
//}
//#pragma mark --valueEntryDelegate
//- (void)okWithAnswer:(answersModel *)answersModel
//{
//    [self.answerArr addObject:answersModel];
//    [self addDataWithArray];
//    [self.ConsultTableView reloadData];
//}
//- (void)addDataWithArray
//{
//    static int index = 0;
//    //加载下一题答案
//    self.questModel = _questionPlistArr[index];
//    [self.questionArr addObject:self.questModel];
//    index++;
//}


- (UITableView *)ConsultTableView
{
    if (!_ConsultTableView) {
        _ConsultTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _ConsultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ConsultTableView.tableHeaderView = self.headView;
        self.headView.inputParamBlock = ^(PreParamModel *paramModel) {
            
        };
        _ConsultTableView.delegate = self;
        _ConsultTableView.dataSource = self;
    }
    return _ConsultTableView;
}

- (NSMutableArray *)questionArr
{
    if (!_questionArr) {
        _questionArr = [NSMutableArray array];
//        [_questionArr addObject:self.questModel];
    }
    return _questionArr;
}

- (headQuestionView *)headView
{
    if (!_headView) {
        _headView = [[headQuestionView alloc] initWithFrame:CGRectZero];
       
    }
    return _headView;
}
//- (NSMutableArray *)answerArr
//{
//    if (!_answerArr) {
//        _answerArr = [NSMutableArray array];
//    }
//    return _answerArr;
//}
//
//- (questionModel *)questModel
//{
//    if (!_questModel) {
//        _questModel = [[questionModel alloc] init];
//
//    }
//    return _questModel;
//}
//- (answersModel *)answerModel
//{
//    if (!_answerModel) {
//        _answerModel = [[answersModel alloc] init];
//    }
//    return _answerModel;
//}
//- (NSMutableArray *)SingleSelectedArr
//{
//    if (!_SingleSelectedArr) {
//        _SingleSelectedArr = [[NSMutableArray alloc] init];
//    }
//    return _SingleSelectedArr;
//}
@end
