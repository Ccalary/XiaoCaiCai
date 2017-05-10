//
//  ReviewTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReviewTableViewCell.h"
@interface ReviewTableViewCell()
@property (nonatomic, strong) UILabel *topTitleLabel, *leftBotTimeLabel, *rightResultLabel;
@property (nonatomic, strong) UIView *dividerLine1;
@end

@implementation ReviewTableViewCell

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
    _topTitleLabel.font = SYSTEM_FONT_(15*UIRate);
    _topTitleLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_topTitleLabel];
    
    _leftBotTimeLabel = [[UILabel alloc] init];
    _leftBotTimeLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftBotTimeLabel.textColor = COLOR_LightGray;
    [self.contentView addSubview:_leftBotTimeLabel];
    
    _rightResultLabel = [[UILabel alloc] init];
    _rightResultLabel.font = SYSTEM_FONT_(15*UIRate);
    _rightResultLabel.textAlignment = NSTextAlignmentRight;
    _rightResultLabel.textColor = COLOR_OrangeLight;
    [self.contentView addSubview:_rightResultLabel];
    
    _dividerLine1 = [[UIView alloc] init];
    _dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:_dividerLine1];
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(self.contentView,15)
    .widthIs(60*UIRate)
    .heightIs(15*UIRate);
    [_topTitleLabel setSingleLineAutoResizeWithMaxWidth: ScreenWidth - 60*UIRate];
    
    _leftBotTimeLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_topTitleLabel,6*UIRate)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    
    _rightResultLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(100*UIRate)
    .heightIs(15*UIRate);
    //宽度自适应
    //    [_rightTimeLabel setSingleLineAutoResizeWithMaxWidth: 150];
    
    _dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

#pragma mark - 消息
- (void)setMessageModel:(MessageModel *)messageModel
{
    _messageModel = messageModel;
    
    _topTitleLabel.text = messageModel.messageContent;
    _leftBotTimeLabel.text = [NSDate getTimeStatus:[NSString stringWithFormat:@"%d",messageModel.createdTimestamp]];
    _rightResultLabel.text = @"";
 
}

#pragma mark - 复查
- (void)setReviewModel:(ReviewListModel *)reviewModel
{
    _reviewModel = reviewModel;
    _topTitleLabel.text = reviewModel.brandName;
    _leftBotTimeLabel.text = [NSDate dateWithTimeStamp:reviewModel.handledTime dateFormat:@"yyyy-MM-dd"];
    
    //复查状态
    if (reviewModel.state == 2 ){
        _rightResultLabel.text = @"复查完成";
        _rightResultLabel.textColor = COLOR_Green;
    }else if (reviewModel.state == 1){
        _rightResultLabel.text = @"正在复查";
        _rightResultLabel.textColor = COLOR_OrangeLight;
    }else {
        _rightResultLabel.text = @"";
    }
}

@end
