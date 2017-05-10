//
//  PleaseNameCell_6.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameCell_6.h"
#import "ToolsHelper.h"
#import "DashiPackagePicModel.h"

@interface PleaseNameCell_6()
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIImageView *imageView1, *imageView2, *imageView3,*imageView4;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation PleaseNameCell_6
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.imageArray = [[NSMutableArray alloc] init];
            [self drawView];
        }
        
        return self;
    }
    
+ (PleaseNameCell_6 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"PleaseNameCell_6";
        PleaseNameCell_6 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[PleaseNameCell_6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    
-(void)drawView{
    
    _priceLable = [[UILabel alloc] init];
    _priceLable.font = [UIFont systemFontOfSize:15*UIRate];
    _priceLable.textColor = COLOR_OrangeRed;
    [self.contentView addSubview:_priceLable];
    
    _selectBtn = [[UIButton alloc] init];
    [_selectBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    _selectBtn.userInteractionEnabled = NO;
    [_selectBtn setImage:[UIImage imageNamed:@"btn_weichaxun_s"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];
    
    _imageView1 = [[UIImageView alloc] init];
    _imageView1.tag = 10000;
    [self.contentView addSubview:_imageView1];
    
    _imageView2 = [[UIImageView alloc] init];
    _imageView2.tag = 10001;
    [self.contentView addSubview:_imageView2];
    
    _imageView3 = [[UIImageView alloc] init];
    _imageView3.tag = 10002;
    [self.contentView addSubview:_imageView3];
    
    _imageView4 = [[UIImageView alloc] init];
    _imageView4.tag = 10003;
    [self.contentView addSubview:_imageView4];
    
    _selectBtn.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(15*UIRate)
    .heightIs(15*UIRate);
    
    _priceLable.sd_layout
    .leftSpaceToView(self.contentView,40*UIRate)
    .centerYEqualToView(_selectBtn)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
    
    _imageView1.sd_layout
    .leftEqualToView(_priceLable)
    .topSpaceToView(_priceLable,5*UIRate)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView2.sd_layout
    .leftSpaceToView(_imageView1,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView3.sd_layout
    .leftSpaceToView(_imageView2,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView4.sd_layout
    .leftSpaceToView(_imageView3,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);

}

- (void)setModel:(DashiPackageModel *)model
{
    _model = model;
    
    NSString *str = [NSString stringWithFormat:@"%.2f元套餐",model.priceYuan];
    
    self.priceLable.attributedText = [ToolsHelper changeSomeText:@"套餐" inText:str withColor:COLOR_Gray];
    
    [self.imageArray removeAllObjects];
    
    for (DashiPackagePicModel *picModel in model.picList){
        
        [self.imageArray addObject:picModel.picPath];
    }
    
    for (int i = 0 ; i < self.imageArray.count; i++){
        UIImageView *imageView = (UIImageView *)[self viewWithTag:10000 + i];
        
        [imageView sd_setImageWithURL:IMAGE_URL(self.imageArray[i]) placeholderImage:[UIImage imageNamed:@"task_pic_default_70x70"]];
    }
}

@end
