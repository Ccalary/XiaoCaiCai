//
//  BrandDetailTableViewCell2.m
//  才标网
//
//  Created by caohouhong on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandDetailTableViewCell2.h"
#import "BrandDetailChildrenCell.h"
#import "BrandGoodsModel.h"
#import "BrandFlowModel.h"

@interface BrandDetailTableViewCell2()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isGoods;
@end


@implementation BrandDetailTableViewCell2

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

- (void)drawView{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = COLOR_Gray;
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_titleLabel];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.scrollEnabled = NO;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_mTableView];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _mTableView.sd_layout
    .leftSpaceToView(self.contentView, ScreenWidth/2.0)
    .topEqualToView(self.contentView).offset(5*UIRate)
    .widthIs(ScreenWidth/2.0)
    .bottomEqualToView(self.contentView);
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(ScreenWidth/2.0 - 10*UIRate)
    .heightIs(20*UIRate);
    

    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .widthIs(ScreenWidth)
    .heightIs(1);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"Cell";
    BrandDetailChildrenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[BrandDetailChildrenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setDic:self.dataArray[indexPath.row] andIsGoods:self.isGoods];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *str = [dic objectForKey:@"detailName"];
    CGFloat height = 0;
    if (self.isGoods){
       height = [NSString calculateStringHeightWithWidth:ScreenWidth/2.0 - 40*UIRate - 10*UIRate  font:SYSTEM_FONT_(15*UIRate) string:str] ;
    }else {
       height = [NSString calculateStringHeightWithWidth:ScreenWidth/2.0 - 90*UIRate - 10*UIRate  font:SYSTEM_FONT_(15*UIRate) string:str] ;
    }
    
    return height + 10*UIRate;
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:goodsArray];
    self.isGoods = YES;
    [self.mTableView reloadData];
}

- (void)setFlowArray:(NSArray *)flowArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:flowArray];
    self.isGoods = NO;
    [self.mTableView reloadData];
}

@end
