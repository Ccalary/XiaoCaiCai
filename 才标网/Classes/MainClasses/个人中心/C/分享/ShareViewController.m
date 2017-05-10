//
//  ShareViewController.m
//  才标网
//
//  Created by caohouhong on 17/4/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UserHelper.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)drawView{
    
    UIImageView *imageViewBg = [[UIImageView alloc] init];
    imageViewBg.image = [UIImage imageNamed:@"share_bg"];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_white_12x22"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"share_icon_22x22"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topTextlabel1 = [self creatLabelWithTitle:@"一秒知天下" font:15*UIRate textColot:[UIColor whiteColor]];
    
    UILabel *topTextlabel2 = [self creatLabelWithTitle:@"三分种轻松注册" font:15*UIRate textColot:[UIColor whiteColor]];
    
    UILabel *topTextlabel3 = [self creatLabelWithTitle:[NSString stringWithFormat:@"我是%@",[UserHelper getMemberName]] font:12*UIRate textColot:COLOR_Blue];
    
    UILabel *topTextlabel4 = [self creatLabelWithTitle:@"只选才标商标起名" font:15*UIRate textColot:COLOR_Blue];
    
    UIImageView *codeImageView = [[UIImageView alloc] init];
    codeImageView.image = [UIImage imageNamed:@"share_QRCode_112x112"];
    
    [self.view sd_addSubviews:@[imageViewBg,shareButton,backBtn,topTextlabel1,topTextlabel2,codeImageView,topTextlabel3,topTextlabel4]];
    
    imageViewBg.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    shareButton.sd_layout
    .rightSpaceToView(self.view,0*UIRate)
    .topSpaceToView(self.view,15)
    .widthIs(40*UIRate)
    .heightIs(40*UIRate);
    
    backBtn.sd_layout
    .leftSpaceToView(self.view,0*UIRate)
    .centerYEqualToView(shareButton)
    .widthIs(40*UIRate)
    .heightIs(40*UIRate);
    
    topTextlabel1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,170*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(15*UIRate);
    
    topTextlabel2.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(topTextlabel1,10*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(15*UIRate);

    codeImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,315*UIRate)
    .widthIs(112*UIRate)
    .heightIs(112*UIRate);
    
    topTextlabel3.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(codeImageView,10*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(15*UIRate);
    

    topTextlabel4.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(topTextlabel3,8*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(15*UIRate);
}

- (UILabel *)creatLabelWithTitle:(NSString *)title font:(CGFloat)font textColot:(UIColor *)color{
    UILabel *topTextlabel1 = [[UILabel alloc] init];
    topTextlabel1.text = title;
    topTextlabel1.font = SYSTEM_FONT_(font);
    topTextlabel1.textAlignment = NSTextAlignmentCenter;
    topTextlabel1.textColor = color;
    return topTextlabel1;
}

- (void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareButtonAction{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"share_logo_60x60"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"申请不成功，免费重新申报。"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.58caibiao.com/?route=mobile/home"]
                                          title:@"商标注册，首选才标。"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}

}

@end
