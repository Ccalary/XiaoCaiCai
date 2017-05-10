//
//  BrandDetailChildrenCell.m
//  才标网
//
//  Created by caohouhong on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandDetailChildrenCell.h"

@interface BrandDetailChildrenCell()
@property (nonatomic, strong) UILabel *firstLabel, *secondLabel, *thirdLabel, *fouthLabel ;

@end

@implementation BrandDetailChildrenCell

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
    
    _firstLabel = [[UILabel alloc] init];
    _firstLabel.textColor = COLOR_Gray;
    _firstLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_firstLabel];
    
    _secondLabel = [[UILabel alloc] init];
    _secondLabel.textColor = COLOR_Gray;
    _secondLabel.font = SYSTEM_FONT_(15*UIRate);
    _secondLabel.numberOfLines = 0;
    [self.contentView addSubview:_secondLabel];
    
    _firstLabel.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(40*UIRate)
    .heightIs(15*UIRate);
    
    [_firstLabel setSingleLineAutoResizeWithMaxWidth:100*UIRate];
    
    _secondLabel.sd_layout
    .leftSpaceToView(_firstLabel,10*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(ScreenWidth/2.0 - _firstLabel.frame.size.width - 10*UIRate)
    .autoHeightRatio(0);
    
    /*************************/
    
    _thirdLabel = [[UILabel alloc] init];
    _thirdLabel.textColor = COLOR_Gray;
    _thirdLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_thirdLabel];
    
    _fouthLabel = [[UILabel alloc] init];
    _fouthLabel.textColor = COLOR_Gray;
    _fouthLabel.font = SYSTEM_FONT_(15*UIRate);
    _fouthLabel.numberOfLines = 0;
    [self.contentView addSubview:_fouthLabel];
    
    _thirdLabel.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(90*UIRate)
    .heightIs(15*UIRate);
    
    _fouthLabel.sd_layout
    .leftSpaceToView(_thirdLabel,10*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(ScreenWidth/2.0 - _thirdLabel.frame.size.width - 10*UIRate)
    .autoHeightRatio(0);
    
}

//是商品详情走12Label,不是走另外两个Label
- (void)setDic:(NSDictionary *)dic andIsGoods:(BOOL) isGoods{
    
    if (isGoods){
        _firstLabel.text = [dic objectForKey:@"detailNum"];
        _secondLabel.text = [dic objectForKey:@"detailName"];
    }else {
        _thirdLabel.text = [dic objectForKey:@"detailNum"];
        _fouthLabel.text = [dic objectForKey:@"detailName"];
    }
}

@end
