//
//  MyAlertView.h
//  自定义AlertView
//
//  Created by macbook on 16/9/12.
//  Copyright © 2016年 郑卓青. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyAlertViewBtnDelegate <NSObject>

@optional

-(void)saveClickButton :(UIButton*)saveBtn;

@end

@interface MyAlertView : UIView

@property (nonatomic, weak) id<MyAlertViewBtnDelegate>delegate;

- (void)show;
- (void)close;

@end
