//
//  RewardTaskTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RewardTaskTableViewCell.h"
#import "ToolsHelper.h"

@interface RewardTaskTableViewCell()
@property (nonatomic, strong) UILabel *topTitleLabel, *tagLabel ,*rightMoneyLabel, *rightTimeLabel, *leftNumLabel;
@end

@implementation RewardTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

- (void)drawView{
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.font = SYSTEM_FONT_(16*UIRate);
    _topTitleLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_topTitleLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = SYSTEM_FONT_(16*UIRate);
    _tagLabel.textColor = COLOR_Green;
    _tagLabel.layer.borderWidth = 1;
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.borderColor = COLOR_Green.CGColor;
    [self.contentView addSubview:_tagLabel];
    
    _rightMoneyLabel = [[UILabel alloc] init];
    _rightMoneyLabel.font = SYSTEM_FONT_BOLD_(16*UIRate);
    _rightMoneyLabel.textAlignment = NSTextAlignmentRight;
    _rightMoneyLabel.textColor = COLOR_OrangeRed;
    _rightMoneyLabel.text = @"¥0.00";
    [self.contentView addSubview:_rightMoneyLabel];

    _rightTimeLabel = [[UILabel alloc] init];
    _rightTimeLabel.font = SYSTEM_FONT_(13*UIRate);
    _rightTimeLabel.textColor = COLOR_Gray;
    _rightTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightTimeLabel];

    _leftNumLabel = [[UILabel alloc] init];
    _leftNumLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftNumLabel.textColor = COLOR_OrangeRed;
    [self.contentView addSubview:_leftNumLabel];

    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(self.contentView,20*UIRate)
    .widthIs(60*UIRate)
    .heightIs(20*UIRate);
     [_topTitleLabel setSingleLineAutoResizeWithMaxWidth: ScreenWidth - 100*UIRate];
    
    _rightMoneyLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(_topTitleLabel)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _tagLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(_topTitleLabel,10*UIRate)
    .widthIs(80*UIRate)
    .heightIs(25*UIRate);
    _tagLabel.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _rightTimeLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(_tagLabel)
    .widthIs(100*UIRate)
    .heightIs(15*UIRate);
    //宽度自适应
//    [_rightTimeLabel setSingleLineAutoResizeWithMaxWidth: 150];
    
    _leftNumLabel.sd_layout
    .leftSpaceToView(_tagLabel,10)
    .centerYEqualToView(_tagLabel)
    .widthIs(100*UIRate)
    .heightIs(15*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

//悬赏任务列表
- (void)setTaskModel:(TaskModel *)taskModel
{
    _taskModel = taskModel;
    
    _topTitleLabel.text = taskModel.taskTitle;
    _rightMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",(double)taskModel.priceYuan];
    
    _leftNumLabel.text = [NSString stringWithFormat:@"%d人投稿",taskModel.touGaoNum];
    NSString *isXuangShangFenQian = [NSString stringWithFormat:@"%d",taskModel.isXuanShangFenQian];
    if ([isXuangShangFenQian isEqualToString:@"1"]) {
        _rightTimeLabel.text = @"已经截稿";
    }else{
         _rightTimeLabel.text = [NSString stringWithFormat:@"%@截稿",[NSDate getTimeStatusWithFutureTime:taskModel.expireTime]];
    }

    //起名分类   1-商标起名 2-公司起名
    if (taskModel.namedCategory == 1){
        _tagLabel.text = @"商标起名";
        _tagLabel.textColor = COLOR_Green;
        _tagLabel.layer.borderColor = COLOR_Green.CGColor;
    }else {
        _tagLabel.text = @"公司起名";
        _tagLabel.textColor = COLOR_Blue;
        _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
    }
}


//我的投稿列表
- (void)setMyContriModel:(TaskModel *)myContriModel
{
    _myContriModel = myContriModel;
    
    _topTitleLabel.text = myContriModel.taskTitle;
    _rightMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",(double)myContriModel.priceYuan];
    _leftNumLabel.textColor = COLOR_LightGray;
    if (myContriModel.isXuanShangFenQian == 1){
        _leftNumLabel.text = @"已采纳";
    }else {
        _leftNumLabel.text = @"未采纳";
    }
    
    NSString *isXuangShangFenQian = [NSString stringWithFormat:@"%d",myContriModel.isXuanShangFenQian];
    if ([isXuangShangFenQian isEqualToString:@"1"]) {
        _rightTimeLabel.text = @"已经截稿";
    }else{
        _rightTimeLabel.text = [NSString stringWithFormat:@"%@截稿",[NSDate getTimeStatusWithFutureTime:myContriModel.expireTime]];
    }

    //起名分类   1-商标起名 2-公司起名
    if (myContriModel.namedCategory == 1){
        _tagLabel.text = @"商标起名";
        _tagLabel.textColor = COLOR_Green;
        _tagLabel.layer.borderColor = COLOR_Green.CGColor;
    }else {
        _tagLabel.text = @"公司起名";
        _tagLabel.textColor = COLOR_Blue;
        _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
    }
}

//大师任务列表
- (void)setMasterTaskModel:(TaskModel *)masterTaskModel
{
    _masterTaskModel = masterTaskModel;
    
    _topTitleLabel.text = masterTaskModel.taskTitle;
    _rightMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",(double)masterTaskModel.priceYuan];
    
    NSString *masterStr = [NSString stringWithFormat:@"%@大师",masterTaskModel.dashiMemberName?:@""];
    _leftNumLabel.attributedText = [ToolsHelper changeSomeText:@"大师" inText:masterStr withColor:COLOR_LightGray];
    
//    //1-未支付 2-已支付
//    if (masterTaskModel.state == 1){
//        
//    }
//    _rightTimeLabel.text = [NSString stringWithFormat:@"%@",@"起名完成"];
    //起名分类   1-商标起名 2-公司起名
    if (masterTaskModel.namedCategory == 1){
        _tagLabel.text = @"商标起名";
        _tagLabel.textColor = COLOR_Green;
        _tagLabel.layer.borderColor = COLOR_Green.CGColor;
    }else {
        _tagLabel.text = @"公司起名";
        _tagLabel.textColor = COLOR_Blue;
        _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
    }

}

//我是大师列表
- (void)setAmMasterModel:(TaskModel *)amMasterModel
{
    _amMasterModel = amMasterModel;
    _leftNumLabel.text = [NSString stringWithFormat:@"%d个投稿",amMasterModel.touGaoNum];

    _topTitleLabel.text = amMasterModel.taskTitle;
    _rightMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",(double)amMasterModel.price/100.0];
    
    //起名分类   1-商标起名 2-公司起名
    if (amMasterModel.namedCategory == 1){
        _tagLabel.text = @"商标起名";
        _tagLabel.textColor = COLOR_Green;
        _tagLabel.layer.borderColor = COLOR_Green.CGColor;
    }else {
        _tagLabel.text = @"公司起名";
        _tagLabel.textColor = COLOR_Blue;
        _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
    }
}

@end
