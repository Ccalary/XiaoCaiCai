//
//  informationCell_2.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "informationCell_2.h"
#import "TTGroupTagView.h"

@interface informationCell_2 ()
@property (nonatomic, strong) TTGroupTagView *tagView;
@end

@implementation informationCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

+ (informationCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"informationCell_2";
    informationCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[informationCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    titleLabel.text = @"起名特点";
    [self.contentView addSubview:titleLabel];

    _tagView = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 40*UIRate, ScreenWidth , 45*UIRate)];
    _tagView.translatesAutoresizingMaskIntoConstraints = YES;
    _tagView.tagHeight = 20*UIRate;
    _tagView.borderColor = COLOR_OrangeRed;
    _tagView.textColor = COLOR_OrangeRed;
    _tagView.selBorderColor = COLOR_OrangeRed;
    [self.contentView addSubview:_tagView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,0)
    .widthIs(200*UIRate)
    .heightIs(40*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    NSString *specialStr = model.memberExtend.teDian;
    NSArray *array = [specialStr componentsSeparatedByString:@"#"];
    if (array.count > 0){
        [_tagView addTags:array withCornerScale:0.2];
    }
}

@end
