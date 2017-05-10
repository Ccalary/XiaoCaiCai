//
//  MyAlertView.m
//  自定义AlertView
//
//  Created by macbook on 16/9/12.
//  Copyright © 2016年 郑卓青. All rights reserved.
//

#import "MyAlertView.h"
#import "UIView+Frame.h"
#import <QuartzCore/QuartzCore.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define APPCOLOR [UIColor colorWithRed:255.0/255.0 green:95.0/255.0 blue:0.0/255.0 alpha:1.0]
@interface MyAlertView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic,strong) UIView *alertBgView;
@end


@implementation MyAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;

        self.alertBgView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.width, self.height)];
        self.alertBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertBgView];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"注册前查询,有效提高成功率";
        titleLabel.textColor = COLOR_darkGray;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.alertBgView addSubview:titleLabel];
        
        UIButton *blackBtn = [[UIButton alloc]init];
        [blackBtn setTitle:@"X" forState:UIControlStateNormal];
        [blackBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
         [blackBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertBgView addSubview:blackBtn];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = COLOR_BackgroundColor;
        [self.alertBgView addSubview:lineView];
        
        UILabel *trademarkLabel = [[UILabel alloc]init];
        trademarkLabel.text = @"商标名称";
        trademarkLabel.textColor = COLOR_darkGray;
        trademarkLabel.font = [UIFont systemFontOfSize:16];
        [self.alertBgView addSubview:trademarkLabel];
        
        UILabel *iphoneLabel = [[UILabel alloc]init];
        iphoneLabel.text = @"电话名称";
        iphoneLabel.textColor = COLOR_darkGray;
        iphoneLabel.font = [UIFont systemFontOfSize:16];
        [self.alertBgView addSubview:iphoneLabel];
        
        UITextField *trademarkTF = [[UITextField alloc]init];
        trademarkTF.font = [UIFont systemFontOfSize:16];
        trademarkTF.layer.borderWidth= 1.0f;
        trademarkTF.layer.borderColor = COLOR_LineViewColor.CGColor;
        trademarkTF.layer.cornerRadius = 5;
        
        trademarkTF.secureTextEntry = NO;
        trademarkTF.tag = 1010;
        [self.alertBgView addSubview:trademarkTF];
        
        
        UITextField *iphoneTF = [[UITextField alloc]init];
        iphoneTF.layer.borderWidth = 1;
        iphoneTF.layer.cornerRadius = 5;
        iphoneTF.layer.borderColor = COLOR_LineViewColor.CGColor;

        iphoneTF.font = [UIFont systemFontOfSize:16];
        iphoneTF.placeholder = @"仅官方可见";
        iphoneTF.secureTextEntry = NO;
        iphoneTF.tag = 1011;
        [self.alertBgView addSubview:iphoneTF];
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"免费获取查询结果" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = COLOR_OrangeRed;
         [btn addTarget:self action:@selector(saveClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        
        btn.layer.cornerRadius = 8;
        [btn.layer setBorderWidth:1];//设置边界的宽度
        btn.layer.borderColor = COLOR_OrangeRed.CGColor;
        [self.alertBgView addSubview:btn];
        
        titleLabel.sd_layout
        .leftSpaceToView(self.alertBgView,20*UIRate)
        .topSpaceToView(self.alertBgView,15*UIRate)
        .widthIs(225*UIRate)
        .heightIs(20*UIRate);
        
        blackBtn.sd_layout
        .rightSpaceToView(self.alertBgView,15*UIRate)
        .topSpaceToView(self.alertBgView,15*UIRate)
        .widthIs(20*UIRate)
        .heightIs(20*UIRate);
        
        lineView.sd_layout
        .topSpaceToView(titleLabel,5*UIRate)
        .leftSpaceToView(self.alertBgView,0)
        .rightSpaceToView(self.alertBgView,0)
        .heightIs(1);
        
        trademarkLabel.sd_layout
        .leftSpaceToView(self.alertBgView,20*UIRate)
        .topSpaceToView(lineView,25*UIRate)
        .widthIs(75*UIRate)
        .heightIs(25*UIRate);
        
        
        trademarkTF.sd_layout
        .topSpaceToView(lineView,18*UIRate)
        .leftSpaceToView(trademarkLabel,5*UIRate)
        .widthIs(145*UIRate)
        .heightIs(35*UIRate);
        
        iphoneLabel.sd_layout
        .topSpaceToView(trademarkLabel,30*UIRate)
        .leftSpaceToView(self.alertBgView,20*UIRate)
        .widthIs(75*UIRate)
        .heightIs(25*UIRate);
        
        
        iphoneTF.sd_layout
        .topSpaceToView(trademarkTF,15*UIRate)
        .leftSpaceToView(iphoneLabel,5*UIRate)
        .widthIs(145*UIRate)
        .heightIs(35*UIRate);
        
        btn.sd_layout
        .leftSpaceToView(self.alertBgView,20*UIRate)
        .rightSpaceToView(self.alertBgView,20*UIRate)
        .topSpaceToView(iphoneTF,15*UIRate)
        .bottomSpaceToView(self.alertBgView,15*UIRate);
        
        
        
        
//        UIImageView *titleVeiw=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.width, 55)];
//        titleVeiw.userInteractionEnabled=YES;
//        titleVeiw.image=[UIImage imageNamed:@"notice_title"];
//        [self.alertBgView addSubview:titleVeiw];
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleVeiw.frame)+10, 0, self.alertBgView.width, 30)];
//        titleLabel.text=@"分类编辑";
//        titleLabel.textColor=[UIColor whiteColor];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        [titleVeiw addSubview:titleLabel];
//        
//        UIView *Witeview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleVeiw.frame), self.width, self.height-55)];
//        Witeview.backgroundColor=[UIColor whiteColor];
//        [self addSubview:Witeview];
//        
//        UILabel *goodsName=[[UILabel alloc]initWithFrame:CGRectMake(35, 25, 30, 25)];
//        goodsName.text=@"名称";
//        goodsName.textAlignment=NSTextAlignmentCenter;
//        goodsName.font=[UIFont systemFontOfSize:15];
//        [Witeview addSubview:goodsName];
//        
//        UITextField *goodsTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodsName.frame)+3, 25, 140, 25)];
//        goodsTF.tag = 100;
//        goodsTF.layer.borderWidth = 1;
//        goodsTF.layer.borderColor = [UIColor blackColor].CGColor;
//        goodsTF.layer.cornerRadius = 5;
//        goodsTF.secureTextEntry = NO;
//        [Witeview addSubview:goodsTF];
//        
//        UILabel *sortLabel=[[UILabel alloc]initWithFrame:CGRectMake(35,CGRectGetMaxY(goodsName.frame)+25 , 30, 25)];
//        sortLabel.text=@"排序";
//        sortLabel.textAlignment=NSTextAlignmentCenter;
//        sortLabel.font=[UIFont systemFontOfSize:15];
//        [Witeview addSubview:sortLabel];
//        
//        
//        UITextField *sortTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sortLabel.frame)+3, CGRectGetMaxY(goodsTF.frame)+24, 140, 25)];
//        sortTF.tag = 200;
//        sortTF.layer.borderWidth = 1;
//        sortTF.keyboardType = UIKeyboardTypeNumberPad;
//        sortTF.layer.borderColor = [UIColor blackColor].CGColor;
//        sortTF.layer.cornerRadius = 5;
//        sortTF.secureTextEntry = NO;
//        [Witeview addSubview:sortTF];
//        
//        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        cancelBtn.frame = CGRectMake(self.alertBgView.width-43,-6,50, 50);
//        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cancelBtn setImage:[UIImage imageNamed:@"notice_close"]forState:UIControlStateNormal];
//        [ self.alertBgView addSubview:cancelBtn];
//        
//        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        confirmBtn.frame = CGRectMake((self.width-90)*0.5,CGRectGetMaxY(sortTF.frame)+38,90, 27);
//        [confirmBtn setBackgroundColor:APPCOLOR];
//        confirmBtn.layer.cornerRadius = 5;
//        [confirmBtn addTarget:self action:@selector(saveClickButton:) forControlEvents:UIControlEventTouchUpInside];
//        [confirmBtn setTitle:@"保存" forState:UIControlStateNormal];
//        [Witeview addSubview:confirmBtn];
//
//        [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
    }
    return self;
}

-(void)cancelClick:(UIButton*)canlBtn{

    [self close];
}

-(void)saveClickButton:(UIButton*)saveBtn{
    
    if ([self.delegate respondsToSelector:@selector(saveClickButton:)]) {
        [self.delegate saveClickButton:saveBtn];
    }
    
    UITextField *name = [saveBtn.superview viewWithTag:1010];
    
    UITextField *sort=[saveBtn.superview viewWithTag:1011];
    
    if (name.text.length&&sort.text.length) {
        NSLog(@"名称：%@", name.text);
        NSLog(@"排序: %@",sort.text);
         [self close];
//        [MBProgressHUD showSuccess:@"保存成功!"];
    }
    else{
    
//        [MBProgressHUD showError:@"不能为空!"];
    }
  
}
- (void)show
{
    if (self.bgView) return;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.2;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}

- (void)close
{
    [self.bgView removeFromSuperview];
     self.bgView = nil;
    [self removeFromSuperview];

}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self close];
}

- (void)keyboardWillChange:(NSNotification  *)notification
{
    
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获取动画执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    CGFloat selfY = keyboardY - self.height - 50;
    
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        // 需要执行动画的代码
        self.y = selfY;
        self.bgView.alpha = 0.5;
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
        if (_bgView == nil) {
            //  [self.textField resignFirstResponder];
            [self removeFromSuperview];
        }
    }];
}

@end
