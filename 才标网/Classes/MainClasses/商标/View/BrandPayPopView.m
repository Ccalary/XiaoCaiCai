//
//  BrandPayPopView.m
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandPayPopView.h"

@interface BrandPayPopView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation BrandPayPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        
        _titleArray = @[@"支付宝支付",@"微信支付"];
        _imageArray = @[@"c_alipay_18x18",@"c_wechat_18x18"];
        
        [self drawView];
    }
    return self;
}

- (void)drawView{
    
    CGFloat width = self.frame.size.width;
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50*UIRate)];
    titleLabel.text = @"选择支付方式";
    titleLabel.font = SYSTEM_FONT_(15*UIRate);
    titleLabel.textColor = COLOR_Black;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton *blackBtn = [[UIButton alloc]init];
    [blackBtn setImage:[UIImage imageNamed:@"home_delect_20x20"] forState:UIControlStateNormal];
    [blackBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:blackBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:lineView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,50*UIRate)
    .bottomSpaceToView(self,0);
    
    blackBtn.sd_layout
    .rightSpaceToView(self,15*UIRate)
    .centerYEqualToView(titleLabel)
    .widthIs(30*UIRate)
    .heightIs(30*UIRate);
    
    lineView.sd_layout
    .topSpaceToView(self,49*UIRate)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(1);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:iconImageView];
    
    UILabel *wayLabel = [[UILabel alloc] init];
    wayLabel.font = SYSTEM_FONT_(15*UIRate);
    wayLabel.textColor = COLOR_Black;
    [cell.contentView addSubview:wayLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [cell.contentView addSubview:dividerLine1];
    
    iconImageView.sd_layout
    .leftSpaceToView(cell.contentView, 15*UIRate)
    .centerYEqualToView(cell.contentView)
    .widthIs(18*UIRate)
    .heightIs(18*UIRate);
    
    wayLabel.sd_layout
    .leftSpaceToView(iconImageView, 15*UIRate)
    .centerYEqualToView(cell.contentView)
    .widthIs(150*UIRate)
    .heightIs(20*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(cell.contentView)
    .rightEqualToView(cell.contentView)
    .bottomEqualToView(cell.contentView)
    .heightIs(1);
    
    iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[indexPath.row]]];
    wayLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.wayBlock){
        self.wayBlock((int)indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*UIRate;
}


#pragma mark - Action
//关闭
- (void)cancelClick{
    if (self.closeBlock){
        self.closeBlock();
    }
}

@end
