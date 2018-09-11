//
//  KKPInstructionsViewController.m
//  KKPat
//
//  Created by Wang on 26/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "KKPInstructionsViewController.h"
#import "KKConfiguration.h"
@interface KKPInstructionsViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation KKPInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(84);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
        make.left.equalTo(self.bgView.mas_left);
        make.right.equalTo(self.bgView.mas_right);
        make.bottom.equalTo(self.bgView.mas_bottom);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(60);
        make.left.equalTo(self.bgView.mas_left).offset(32);
        make.right.equalTo(self.bgView.mas_right).offset(-32);
        make.height.equalTo(@12);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(20);
        make.left.equalTo(self.bgView.mas_left).offset(32);
        make.right.equalTo(self.bgView.mas_right).offset(-32);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-20);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        [_bgView addSubview:self.imageView];
        [_bgView addSubview:self.titleLab];
        [_bgView addSubview:self.contentLab];
    }
    return _bgView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLab setFont:[UIFont systemFontOfSize:12]];
        [_titleLab setTextColor:[UIColor whiteColor]];
        _titleLab.text = @"本APP的使用说明";
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        [_contentLab setFont:[UIFont systemFontOfSize:11]];
        [_contentLab setTextColor:[UIColor whiteColor]];
        _contentLab.numberOfLines = 0;
//        [_contentLab setContentMode:UIViewContentModeTop];
        [_contentLab sizeToFit];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"instruction" ofType:@"txt"];
        _contentLab.text = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return _contentLab;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.image = IMG(@"bg_instruction_bg");
    }
    return _imageView;
}
@end
