//
//  BrandSearchTextVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchTextVC.h"
#import "BrandSearchResultVC.h"
#import "CBConnect.h"
#import "BrandSearchModel.h"
#import "LoginViewController.h"
#import "UserHelper.h"
@interface BrandSearchTextVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *mTextField;
@end

@implementation BrandSearchTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"文字检索";
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mTextField becomeFirstResponder];
}

- (void)drawView{
    
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapAction)];
    aTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:aTap];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"文字检索";
    textlabel.font = SYSTEM_FONT_(18*UIRate);
    textlabel.textColor = COLOR_Black;
    [self.view addSubview:textlabel];
    
    UIView *kuangView = [[UIView alloc] init];
    kuangView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    kuangView.layer.borderWidth = 1;
    kuangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:kuangView];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:dividerLine1];
    
    UIImageView *searchImage = [[UIImageView alloc] init];
    searchImage.image = [UIImage imageNamed:@"brand_s_search_19x19"];
    [self.view addSubview:searchImage];
    
    _mTextField = [[UITextField alloc] init];
    _mTextField.placeholder = @"请输入商标名称 例如：玄博";
    _mTextField.delegate = self;
    _mTextField.returnKeyType = UIReturnKeySearch;
    _mTextField.font = SYSTEM_FONT_(15*UIRate);
    _mTextField.textColor = COLOR_darkGray;
    [self.view addSubview:_mTextField];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:COLOR_OrangeLight];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    textlabel.sd_layout
    .leftSpaceToView(self.view, 15*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    kuangView.sd_layout
    .leftSpaceToView(self.view, 15*UIRate)
    .topSpaceToView(self.view,50*UIRate)
    .widthIs(ScreenWidth - 90*UIRate)
    .heightIs(40*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(kuangView).offset(40*UIRate)
    .centerYEqualToView(kuangView)
    .widthIs(1)
    .heightRatioToView(kuangView,1);
    
    searchImage.sd_layout
    .leftEqualToView(kuangView).offset(10*UIRate)
    .centerYEqualToView(kuangView)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    _mTextField.sd_layout
    .leftEqualToView(kuangView).offset(45*UIRate)
    .centerYEqualToView(kuangView)
    .widthIs(ScreenWidth - 140*UIRate)
    .heightRatioToView(kuangView,1);
    
    searchBtn.sd_layout
    .rightSpaceToView(self.view, 15*UIRate)
    .centerYEqualToView(kuangView)
    .widthIs(65*UIRate)
    .heightRatioToView(kuangView,1);
}


- (void)aTapAction{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.returnKeyType == UIReturnKeySearch)
    {
        [self searchBtnAction];
    }
    
    return YES;
}

//搜索
- (void)searchBtnAction{
    [self.view endEditing:YES];
    
    if (self.mTextField.text.length==0){
        [LCProgressHUD showMessage:@"请输入要搜索的内容"];
        return;
    }
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }

    BrandSearchResultVC *vc = [[BrandSearchResultVC alloc] init];
    vc.mTextField = self.mTextField.text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
