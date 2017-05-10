//
//  IamMasterDetailsCell_2.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterDetailsCell_2.h"

@implementation IamMasterDetailsCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (IamMasterDetailsCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"IamMasterDetailsCell_2";
    IamMasterDetailsCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[IamMasterDetailsCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}




-(void)drawView{
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"释义名称:";
    titlelabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:titlelabel];
    
    UITextField *nameFD = [[UITextField alloc]init];
    nameFD.placeholder = @"请输入商标名称";
    nameFD.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:nameFD];
    
    UILabel *instructionsLabel = [[UILabel alloc]init];
    instructionsLabel.text = @"释义说明:";
    instructionsLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:instructionsLabel];
    
    UITextView *textView = [[UITextView alloc]init];
    textView.placeholder = @"释义说明";
    textView.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:textView];
    
    titlelabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(75*UIRate)
    .heightIs(20*UIRate);
    
    nameFD.sd_layout
    .leftSpaceToView(titlelabel,5*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .heightIs(20*UIRate);
    
    instructionsLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titlelabel,10*UIRate)
    .widthIs(75*UIRate)
    .heightIs(20*UIRate);
    
    textView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(instructionsLabel,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .heightIs(100*UIRate);
    
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
