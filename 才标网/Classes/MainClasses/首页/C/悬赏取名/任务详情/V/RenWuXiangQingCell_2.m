//
//  RenWuXiangQingCell_2.m
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_2.h"
#import "TTGroupTagView.h"
@interface RenWuXiangQingCell_2 ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *requirementsLabel;
@property (nonatomic, weak) UILabel *titleLabel;
    
@end

@implementation RenWuXiangQingCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (RenWuXiangQingCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RenWuXiangQingCell_2";
    RenWuXiangQingCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RenWuXiangQingCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    
    self.leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:13*UIRate];
    _leftLabel.textColor = HEXCOLOR(0x999999);
    _leftLabel.text = @"任务编号：2010204100838217";
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_leftLabel];

    self.dataLabel = [[UILabel alloc] init];
    _dataLabel.font = [UIFont systemFontOfSize:10*UIRate];
    _dataLabel.textColor = HEXCOLOR(0xc7c7cd);
    _dataLabel.text = @"2017-02-04";
    _dataLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dataLabel];
    
    
    UIView *xianView = [[UIView alloc]init];
    xianView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:xianView];
    
    
    self.hangYeLabel = [[UILabel alloc] init];
    _hangYeLabel.font = [UIFont systemFontOfSize:13*UIRate];
    _hangYeLabel.textColor = HEXCOLOR(0x999999);
    _hangYeLabel.text = @"所属行业：03类洗护用品";
    _hangYeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_hangYeLabel];
    
    UIView *xianView1 = [[UIView alloc]init];
    xianView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:xianView1];
    
    self.RenWuLabel = [[UILabel alloc] init];
    _RenWuLabel.font = [UIFont systemFontOfSize:13*UIRate];
    _RenWuLabel.textColor = HEXCOLOR(0x999999);
    _RenWuLabel.text = @"任务要求：";
    _RenWuLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_RenWuLabel];
    
    self.tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:12*UIRate];
    [self.contentView addSubview:_tagLabel];
    
    self.tagView = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 122*UIRate, ScreenWidth, 50*UIRate)];
    _tagView.translatesAutoresizingMaskIntoConstraints = YES;
    _tagView.backgroundColor = [UIColor whiteColor];
    _tagView.fontTag = [UIFont systemFontOfSize:12*UIRate];
    _tagView.tagHeight = 20*UIRate;
    UIColor *randomColor = (arc4random()%2 == 1) ? COLOR_OrangeRed : COLOR_Green;
    _tagView.textColor = randomColor;
    _tagView.borderColor = randomColor;
    _tagView.selBorderColor = randomColor;
    _tagView.selTextColor = randomColor;
    [self.contentView addSubview:_tagView];
    
    
    self.tagLabel1 = [[UILabel alloc] init];
    _tagLabel1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_tagLabel1];
    
    
//    UITextView *neiRongView = [[UITextView alloc]init];
//    neiRongView.text = @"做洗发液产品推广，主要是男士洗发液，需要一个商标注册名字，谢谢";
//    [self.contentView addSubview:neiRongView];
    
    self.requirementsLabel = [[UILabel alloc]init];
    _requirementsLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _requirementsLabel.numberOfLines = 0;
    [self.contentView addSubview:_requirementsLabel];
    
    
    UIView *xianView2 = [[UIView alloc]init];
    xianView2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:xianView2];
    
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = HEXCOLOR(0x999999);
    _nameLabel.text = @"发布者：洋葱";
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(250*UIRate)
    .heightIs(20*UIRate);
    
    _dataLabel.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .leftSpaceToView(_leftLabel,10*UIRate)
    .topEqualToView(_leftLabel)
    .bottomEqualToView(_leftLabel);
    
    xianView.sd_layout
    .leftEqualToView(_leftLabel)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_leftLabel,10*UIRate)
    .heightIs(1);
    
    _hangYeLabel.sd_layout
    .leftEqualToView(xianView)
    .topSpaceToView(xianView,10*UIRate)
    .widthIs(250*UIRate)
    .heightIs(20*UIRate);
    
    xianView1.sd_layout
    .leftEqualToView(_hangYeLabel)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_hangYeLabel,10*UIRate)
    .heightIs(1);
    
    _RenWuLabel.sd_layout
    .leftEqualToView(xianView1)
    .topSpaceToView(xianView1,10*UIRate)
    .widthIs(250*UIRate)
    .heightIs(20*UIRate);
    
   _requirementsLabel.sd_layout
    .leftEqualToView(_RenWuLabel)
    .topSpaceToView(_tagView,10*UIRate)
    .rightSpaceToView(self.contentView,1)
    .autoHeightRatio(0);
    
    xianView2.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(_requirementsLabel,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .heightIs(1);
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(xianView2,5*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .heightIs(20*UIRate);
    
   
    
    
}
    
- (void)textViewDidChange:(UITextView *)textView
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%ld/200",(unsigned long)textView.text.length];
        
        if (self.didHaveAttr1) {
            self.didHaveAttr1(textView.text);
        }
    }

-(void)setTaskModel:(TaskModel *)model itemContents:(NSArray *)arr{
    self.leftLabel.text = [NSString stringWithFormat:@"任务编号:%@",model.taskCode];
    DLog(@"%@",model.taskCode);
    self.dataLabel.text = [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
    self.hangYeLabel.text = [NSString stringWithFormat:@"所属行业:%@",model.categoryName];
    self.requirementsLabel.text = model.requireDetail;
    self.nameLabel.text = [NSString stringWithFormat:@"发布者:%@",model.creatorName];
    if (!_recentHeightArray) {
        _recentHeightArray = [NSMutableArray array];
    }
    
    
    [_tagView addTags:arr withCornerScale:0.5];
      [self.recentHeightArray addObject:[NSString stringWithFormat:@"%f", _tagView.changeHeight]];
   
}

@end
