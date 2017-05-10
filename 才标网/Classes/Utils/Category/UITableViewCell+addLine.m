//
//  UITableViewCell+addLine.m
//  lingdaozhe
//
//  Created by aliviya on 16/5/20.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "UITableViewCell+addLine.h"



@implementation UITableViewCell (addLine)


-(void)addUplineWithLeftMargin{
    if ([self viewWithTag:1001]) {
        return;
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.tag  =1001;
    lineView.backgroundColor = COLOR_LineViewColor;
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(0.5);
}


-(void)addUnderlineWithLeftMargin:(float)leftMargin{
    if ([self viewWithTag:1000]) {
        UIView *line =(UIView *)[self viewWithTag:1000];
        [line removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.tag  =1000;
    lineView.backgroundColor = COLOR_LineViewColor;
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self,leftMargin)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(0.5);
}

-(void)addUnderlineWithLeftMargin:(float)leftMargin rightMargin:(float)rightMargin lineHeight:(float)lineHeight
{
    if ([self viewWithTag:1000]) {
        UIView *line =(UIView *)[self viewWithTag:1000];
        [line removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.tag  =1000;
    lineView.backgroundColor = COLOR_LineViewColor;
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self,leftMargin)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,rightMargin)
    .heightIs(lineHeight);
}

-(void)addUnderlineWithLeftMargin:(float)leftMargin rightMargin:(float)rightMargin lineHeight:(float)lineHeight backgroundColor:(UIColor *)backgroundColor
{
    if ([self viewWithTag:1000]) {
        UIView *line =(UIView *)[self viewWithTag:1000];
        [line removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.tag  =1000;
    lineView.backgroundColor = backgroundColor;
    [self addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self,leftMargin)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,rightMargin)
    .heightIs(lineHeight);
}

-(void)removeUnderLine{
    if ([self viewWithTag:1000]) {
        UIView *line =(UIView *)[self viewWithTag:1000];
        [line removeFromSuperview];
    }
}
@end
