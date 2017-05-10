//
//  UITableViewCell+addLine.h
//  lingdaozhe
//
//  Created by aliviya on 16/5/20.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (addLine)
-(void)addUplineWithLeftMargin;
-(void)addUnderlineWithLeftMargin:(float)leftMargin;
-(void)removeUnderLine;
-(void)addUnderlineWithLeftMargin:(float)leftMargin rightMargin:(float)rightMargin lineHeight:(float)lineHeight;
-(void)addUnderlineWithLeftMargin:(float)leftMargin rightMargin:(float)rightMargin lineHeight:(float)lineHeight backgroundColor:(UIColor *)backgroundColor;

@end
