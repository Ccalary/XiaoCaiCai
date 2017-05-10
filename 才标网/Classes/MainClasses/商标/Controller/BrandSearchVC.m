//
//  BrandSearchVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchVC.h"
#import "BrandSearchTextVC.h"
#import "BrandSearchImageVC.h"
#import "BrandCategoryVC.h"

@interface BrandSearchVC ()

@end

@implementation BrandSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商标查询";
    [self drawView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

- (void)drawView{
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"brand_s_logo_232x84"];
    [self.view addSubview:topImageView];
    
    UIButton *textSearchBtn = [self creatButtonWithTitle:@"" andImage:[UIImage imageNamed:@"brand_s_text_125x125"] andTag:10000];
    [self.view addSubview:textSearchBtn];
    
    UIButton *imageSearchBtn = [self creatButtonWithTitle:@"" andImage:[UIImage imageNamed:@"brand_s_img_125x125"] andTag:10001];
    [self.view addSubview:imageSearchBtn];
    
    
    UILabel *textSearchLabel = [[UILabel alloc]init];
    textSearchLabel.font = [UIFont systemFontOfSize:15*UIRate];
    textSearchLabel.text = @"文字检索";
    textSearchLabel.textAlignment = NSTextAlignmentCenter;
    [textSearchBtn addSubview:textSearchLabel];
    
    UILabel *imageSearchLabel = [[UILabel alloc]init];
    imageSearchLabel.font = [UIFont systemFontOfSize:15*UIRate];
    imageSearchLabel.text = @"图形检索";
    imageSearchLabel.textAlignment = NSTextAlignmentCenter;
    [imageSearchBtn addSubview:imageSearchLabel];
    
    
    UILabel *bottomTextlabel = [[UILabel alloc] init];
    bottomTextlabel.text = @"搜不到想要的?不如来逛逛商城";
    bottomTextlabel.font = SYSTEM_FONT_(15*UIRate);
    bottomTextlabel.backgroundColor = COLOR_OrangeLight;
    bottomTextlabel.textAlignment = NSTextAlignmentCenter;
    bottomTextlabel.textColor = [UIColor whiteColor];
    [self.view addSubview:bottomTextlabel];
    
    UIButton *mallBtn = [[UIButton alloc] init];
    [mallBtn setImage:[UIImage imageNamed:@"brand_s_shop_77x77"] forState:UIControlStateNormal];
    mallBtn.backgroundColor = [UIColor clearColor];
    [mallBtn addTarget:self action:@selector(mallBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mallBtn];
    
    topImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,85*UIRate)
    .widthIs(232*UIRate)
    .heightIs(84*UIRate);
    
    textSearchBtn.sd_layout
    .leftSpaceToView(self.view,10*UIRate)
    .topSpaceToView(topImageView,85*UIRate)
    .widthIs((ScreenWidth - 30*UIRate)/2)
    .heightIs(180*UIRate);
    
    textSearchLabel.sd_layout
    .centerXEqualToView(textSearchBtn)
    .bottomSpaceToView(textSearchBtn,10*UIRate)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    imageSearchBtn.sd_layout
    .rightSpaceToView(self.view,10*UIRate)
    .centerYEqualToView(textSearchBtn)
    .widthIs((ScreenWidth - 30*UIRate)/2)
    .heightIs(180*UIRate);
    
    imageSearchLabel.sd_layout
    .centerXEqualToView(imageSearchBtn)
    .bottomSpaceToView(imageSearchBtn,10*UIRate)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    
    bottomTextlabel.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(55*UIRate);
    
    mallBtn.sd_layout
    .rightSpaceToView(self.view,15*UIRate)
    .bottomSpaceToView(self.view,20*UIRate)
    .widthIs(77*UIRate)
    .heightIs(77*UIRate);
}

//创建按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title andImage:(UIImage *)image andTag:(int)tag{
    
    UIButton *textSearchBtn = [[UIButton alloc] init];
    [textSearchBtn setTitle:title forState:UIControlStateNormal];
    [textSearchBtn setBackgroundImage:image forState:UIControlStateNormal];
    [textSearchBtn setTitleColor:COLOR_Black forState:UIControlStateNormal];
    textSearchBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    textSearchBtn.tag = tag;
    textSearchBtn.backgroundColor = [UIColor whiteColor];
    [textSearchBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return textSearchBtn;
}

- (void)btnAction:(UIButton *)btn{
    if (btn.tag == 10000){ //文字检索
        
        BrandSearchTextVC *vc = [[BrandSearchTextVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else { //图像检索
        BrandSearchImageVC *vc = [[BrandSearchImageVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

///逛逛商城
- (void)mallBtnAction{
    BrandCategoryVC *vc = [[BrandCategoryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
