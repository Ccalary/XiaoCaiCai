//
//  masterListCell.m
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterListCell.h"
#import "TTGroupTagView.h"

@interface masterListCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel, *addressLabel,*tagLabel1,*tagLabel2;
@property (nonatomic, strong) TTGroupTagView *tagView;
@end

@implementation masterListCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    return self;
}

- (void)drawView{
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_iconImageView];
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _nameLabel.textColor = COLOR_darkGray;
//    _nameLabel.text = @"章国兴";
    [self.contentView addSubview:_nameLabel];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.font = [UIFont systemFontOfSize:12*UIRate];
    _addressLabel.textColor = COLOR_LightGray;
//    _addressLabel.text = @"江苏";
    _addressLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_addressLabel];
    
    _tagLabel1 = [[UILabel alloc]  init];
    _tagLabel1.layer.borderWidth = 1;
    _tagLabel1.layer.borderColor = COLOR_OrangeRed.CGColor;
    _tagLabel1.font = SYSTEM_FONT_(13*UIRate);
    _tagLabel1.textColor = COLOR_OrangeRed;
    [self.contentView addSubview:_tagLabel1];
    
    _tagLabel2 = [[UILabel alloc]  init];
    _tagLabel2.layer.borderWidth = 1;
    _tagLabel2.layer.borderColor = COLOR_OrangeRed.CGColor;
    _tagLabel2.font = SYSTEM_FONT_(13*UIRate);
    _tagLabel2.textColor = COLOR_OrangeRed;
    [self.contentView addSubview:_tagLabel2];
    
    _tagView = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 215*UIRate, (ScreenWidth - 20*UIRate)/2.0, 40*UIRate)];
    _tagView.translatesAutoresizingMaskIntoConstraints = YES;
    _tagView.tagHeight = 20*UIRate;
    _tagView.borderColor = COLOR_OrangeRed;
    _tagView.textColor = COLOR_OrangeRed;
    _tagView.selBorderColor = COLOR_OrangeRed;
    
    [self.contentView addSubview:_tagView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(170*UIRate);
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(_iconImageView,15*UIRate)
    .rightSpaceToView(self.contentView,80*UIRate)
    .heightIs(15*UIRate);
    
    _addressLabel.sd_layout
    .rightSpaceToView(self.contentView,5*UIRate)
    .bottomEqualToView(_nameLabel)
    .widthIs(80*UIRate)
    .heightIs(15*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_nameLabel,5*UIRate)
    .heightIs(1);
    
    _tagLabel1.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(0)
    .heightIs(20*UIRate);
    [_tagLabel1 setSingleLineAutoResizeWithMaxWidth:(ScreenWidth - 40*UIRate)/4.0];
    _tagLabel1.sd_cornerRadiusFromHeightRatio = @(0.2);
    
    _tagLabel2.sd_layout
    .leftSpaceToView(_tagLabel1,3*UIRate)
    .centerYEqualToView(_tagLabel1)
    .widthIs(0)
    .heightIs(20*UIRate);
    [_tagLabel2 setSingleLineAutoResizeWithMaxWidth:(ScreenWidth - 40*UIRate)/4.0];
    _tagLabel2.sd_cornerRadiusFromHeightRatio = @(0.2);
    
}

- (void)setMasterModel:(ModelMember *)masterModel
{
    _masterModel = masterModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:masterModel.portrait]  placeholderImage:[UIImage imageNamed:@"home_master_default_165x145"]];
    self.nameLabel.text = masterModel.memberName;
    self.addressLabel.text = masterModel.memberExtend.provinceName ? masterModel.memberExtend.provinceName : @"";
    
    NSString *specialStr = masterModel.memberExtend.teDian;
    NSArray *array = [specialStr componentsSeparatedByString:@"#"];
    //删除标签，预防重复加入
    [_tagView deleteAllTags];
    if (array.count > 0){
    
        //显示的tag个数处理
        NSMutableArray *tagArray = [[NSMutableArray alloc] init];
        int strLength = 0;
    
        for (NSString *str in array){
            
            strLength = (int)str.length + strLength;
            if (strLength <= 8 && tagArray.count < 3){//限制容纳8个字，3个标签
                [tagArray addObject:str];
               
            }else {
                break;
            }
        }
        [_tagView addTags:tagArray withCornerScale:0.2];
    }
}

@end
