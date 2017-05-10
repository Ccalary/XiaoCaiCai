//
//  InformationCell_4.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "InformationCell_4.h"
#import "ModelMemberCase.h"

@interface InformationCell_4()
@property (nonatomic, assign) int rowNum;
@end

@implementation InformationCell_4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andNum:(int) num
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.rowNum = num;
            [self drawView];
        }
        return self;
}
    
+ (InformationCell_4 *)cellWithTableView:(UITableView *)tableView andBtnNum:(int)num
    {
        static NSString *idenifier = @"InformationCell_4";
        InformationCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[InformationCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    titleLabel.text = @"起名案例";
    [self.contentView addSubview:titleLabel];
    
    CGFloat btnWH = (ScreenWidth - 40*UIRate)/3.0;
    CGFloat btnSpace = 10*UIRate;
    
    for (int i = 0 ; i < self.rowNum; i++) {
        NSInteger index = i % 3; //列
        NSInteger page = i / 3;// 行
        UIImageView *aImage = [[UIImageView alloc] init];
        aImage.tag = 10000+i;
        aImage.frame = CGRectMake(index * (btnWH + btnSpace) + btnSpace, page  * (btnWH + btnSpace) + 45*UIRate, btnWH, btnWH);
        
        [self.contentView addSubview:aImage];
    }
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(self.contentView,15*UIRate)
    .heightIs(20*UIRate);
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    NSArray *array = model.caseList;
    
    for (int i = 0 ; i < self.rowNum; i++){
        ModelMemberCase *model = array[i];
        NSString *imageStr = model.picPath;
        UIImageView *aImage = (UIImageView *)[self.contentView viewWithTag:10000+i];
        [aImage sd_setImageWithURL:IMAGE_URL(imageStr) placeholderImage:[UIImage imageNamed:@"task_pic_default_70x70"]];
    }
}

@end
