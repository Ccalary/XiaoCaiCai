//
//  IamMasterDetailsCell_1.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterDetailsCell_1.h"
#import "EditpageCell.h"
#import "UserHelper.h"

@interface IamMasterDetailsCell_1 ()

@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat totalHeight;
@end

@implementation IamMasterDetailsCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
+ (IamMasterDetailsCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"IamMasterDetailsCell_1";
    IamMasterDetailsCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[IamMasterDetailsCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    
    self.nameLabel = [[UILabel alloc]init];
//    _nameLabel.text = @"洋葱:";
    _nameLabel.textColor = COLOR_Gray;
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_nameLabel];
    
    self.answerLabel = [[UILabel alloc]init];
//    _answerLabel.text = @"跟我生辰八字有啥关系？";
    _answerLabel.numberOfLines = 0;
    _answerLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_answerLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate)
    .widthIs(100*UIRate);
    
    _answerLabel.sd_layout
    .leftSpaceToView(_nameLabel,5*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .autoHeightRatio(0);
    
}

- (void)setModel:(TaskAskAnswerListModel *)model{
    _model = model;
    
    NSString *userName = [UserHelper getMemberName];
    
    if ([userName isEqualToString:_model.creatorName]) {
       self.nameLabel.text = [NSString stringWithFormat:@"%@提问:",_model.creatorName];
    }else{
        self.nameLabel.text = [NSString stringWithFormat:@"%@回复:",_model.creatorName];
    }
    self.answerLabel.text = _model.content;
}

@end
