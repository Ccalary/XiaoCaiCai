
//
//  CategoryPopView.m
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "CategoryPopView.h"
#import "CatePopTableViewCell.h"

@interface CategoryPopView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CategoryPopView

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self.dataArray addObjectsFromArray:array];
        [self drawView];
    }
    return self;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)drawView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:_tableView];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topEqualToView(self)
    .bottomSpaceToView(self,40*UIRate);
    
    btn.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomEqualToView(self)
    .heightIs(40*UIRate);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    CatePopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[CatePopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.topTitleLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*UIRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.block){
        self.block((int)indexPath.row);
    }
}

//取消按钮
- (void)btnAction{
    if (self.block){
        self.block(-1);
    }
}

@end
