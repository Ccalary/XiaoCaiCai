//
//  contributeVC.m
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "contributeVC.h"
#import "queryVC.h"
#import "CBConnect.h"
#import "ToolsHelper.h"
#import "ServiceVC.h"
typedef void(^DidHaveAttr1)(NSString *str);

@interface contributeVC ()<UITextViewDelegate,UITextFieldDelegate>
    {
        NSString *state;
        int isCheck;
        UILabel *wordsLabel;

        
    }
@property (nonatomic, copy) DidHaveAttr1 didHaveAttr1;

@property(nonatomic,strong)UIButton *querybtn;
@property(nonatomic,strong)UIButton *noQuerybtn;
@property(nonatomic,strong)UITextField *nameFidld;
@property(nonatomic,strong)UITextView *textview;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation contributeVC

- (void)viewDidLoad {
    [super viewDidLoad];
   state = @"0";
   self.navigationItem.title = @"任务投稿";
    isCheck = 0;
    [self drawView];

}
-(void)drawView{
//    self.view.backgroundColor = COLOR_BackgroundColor;
    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"投稿名称:";
//    nameLabel.backgroundColor = HEXCOLOR(0xeeeeee);
    nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nameLabel];
    
    self.nameFidld = [[UITextField alloc]init];
     _nameFidld.placeholder = @"请输入商标名称";
    _nameFidld.backgroundColor = [UIColor whiteColor];
    _nameFidld.font = [UIFont systemFontOfSize:15*UIRate];
//    _nameFidld.keyboardAppearance = UIKeyboardAppearanceAlert;
    _nameFidld.delegate = self;
    [self.view addSubview:_nameFidld];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:lineView];
    
    UILabel *isQueryLabel = [[UILabel alloc]init];
    isQueryLabel.text = @"是否查询:";
    isQueryLabel.font = [UIFont systemFontOfSize:15*UIRate];
    isQueryLabel.textColor = [UIColor blackColor];
    isQueryLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:isQueryLabel];
  
    self.noQuerybtn = [[UIButton alloc]init];
    [self.noQuerybtn addTarget:self action:@selector(inside:) forControlEvents:UIControlEventTouchUpInside];
    [self.noQuerybtn setTitle:@"未查询" forState:UIControlStateNormal];
    self.noQuerybtn.tag = 123456;
    [self.noQuerybtn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    self.noQuerybtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.noQuerybtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    if ([state isEqualToString:@"1"]) {
        [self.noQuerybtn setImage:[UIImage imageNamed:@"icon_yes"] forState:UIControlStateNormal];
    }else{
        [self.noQuerybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.noQuerybtn];
    self.querybtn = [[UIButton alloc]init];
    [self.querybtn addTarget:self action:@selector(inside:) forControlEvents:UIControlEventTouchUpInside];
    [self.querybtn setTitle:@"已查询" forState:UIControlStateNormal];
    self.querybtn.tag = 1234567;
    [self.querybtn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    self.querybtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.querybtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    if ([state isEqualToString:@"1"]) {
        [self.querybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    }else{
         [self.querybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n-1"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.querybtn];
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:lineView1];
    self.textview = [[UITextView alloc]init];
    _textview.placeholder = @"释义说明";
    _textview.delegate = self;
    
    [self.view addSubview:_textview];
    wordsLabel = [[UILabel alloc]init];
    wordsLabel.text = @"0/200";
    wordsLabel.font = [UIFont systemFontOfSize:13*UIRate];
    wordsLabel.textColor = [UIColor blackColor];
    wordsLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:wordsLabel];
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = COLOR_BackgroundColor;
    
    [self.view addSubview:backgroundView];
    UILabel *travelLabel = [[UILabel alloc]init];
    NSString *text = @"前往查询中心看看能否注册";
    travelLabel.font = [UIFont systemFontOfSize:15*UIRate];
    travelLabel.textColor = [UIColor blackColor];
    travelLabel.attributedText = [ToolsHelper changeSomeText:@"查询中心" inText:text withColor:HEXCOLOR(0xff5c0b)];
    [backgroundView addSubview:travelLabel];
    
    UIButton *querybtn = [[UIButton alloc]init];
    [querybtn addTarget:self action:@selector(queryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:querybtn];
    
       self.submitBtn = [[UIButton alloc]init];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
     _submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _submitBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    _submitBtn.layer.cornerRadius = 15;
    _submitBtn.clipsToBounds = YES;
    [backgroundView addSubview:_submitBtn];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(serviceBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBtn];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,120*UIRate)
    .widthIs(50*UIRate)
    .heightIs(50*UIRate);
    
    nameLabel.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .widthIs(75*UIRate)
    .heightIs(30*UIRate);
    
    _nameFidld.sd_layout
    .leftSpaceToView(nameLabel,10*UIRate)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10*UIRate)
    .heightIs(30*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(nameLabel,5*UIRate)
    .heightIs(1);
    
    isQueryLabel.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(75*UIRate)
    .heightIs(30*UIRate);
    
    _noQuerybtn.sd_layout
    .leftSpaceToView(isQueryLabel,10*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(80*UIRate)
    .heightIs(30*UIRate);
    
    _querybtn.sd_layout
    .leftSpaceToView(_noQuerybtn,15)
    .topSpaceToView(lineView,5*UIRate)
    .heightIs(30*UIRate)
    .widthIs(80*UIRate);
    
    lineView1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(1)
    .topSpaceToView(isQueryLabel,5*UIRate);
    
    _textview.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(lineView1,5*UIRate)
    .heightIs(120*UIRate);
    
    wordsLabel.sd_layout
    .rightSpaceToView(self.view,10*UIRate)
    .topSpaceToView(lineView1,105*UIRate)
    .heightIs(30*UIRate)
    .widthIs(60*UIRate);
    
    backgroundView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_textview,0)
    .bottomSpaceToView(self.view,0);
    
    travelLabel.sd_layout
    .leftSpaceToView(backgroundView,95*UIRate)
    .topSpaceToView(backgroundView,15*UIRate)
    .rightSpaceToView(backgroundView,40*UIRate)
    .heightIs(20*UIRate);
    
    querybtn.sd_layout
    .leftSpaceToView(backgroundView,115*UIRate)
    .topSpaceToView(backgroundView,10*UIRate)
    .rightSpaceToView(backgroundView,90*UIRate)
    .heightIs(30*UIRate);
    
    _submitBtn.sd_layout
    .topSpaceToView(travelLabel,35*UIRate)
    .centerXEqualToView(backgroundView)
    .heightIs(40*UIRate)
    .widthIs(293*UIRate);
    
    
}
   //客服
-(void)serviceBtn{
    
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
   //提交
-(void)submit{
    
    [self requestData];
    
}
//查询中心
-(void)queryBtnAction{
    
    queryVC *vc = [[queryVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}
    //是否查询
-(void)inside:(UIButton *)btn{
    if (btn.tag == 1234567) {
        state = @"1";
        isCheck = 1;
        [self.querybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n-1"] forState:UIControlStateNormal];
        [self.noQuerybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:(UIControlStateNormal)];
        DLog(@"已经查询");
    }else{
        state = @"0";
        isCheck = 0;
        [self.noQuerybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n-1"] forState:UIControlStateNormal];
        [self.querybtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:(UIControlStateNormal)];
    }
    
}
//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


- (void)textViewDidChange:(UITextView *)textView
{
    wordsLabel.text = [NSString stringWithFormat:@"%ld/200",(unsigned long)textView.text.length];
    
    if (self.didHaveAttr1) {
        self.didHaveAttr1(textView.text);
    }
}
#pragma mark - ============网络－我要投稿===============
- (void)requestData {
    [LCProgressHUD showLoading:@"提交中"];
    UIImage *image = [UIImage imageNamed:@"none"];
    NSArray *array = @[image];
    
     NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    if (!self.nameFidld.text.length) {
        [LCProgressHUD showFailure:@"请输入商标名称"];
        return;
    }
    if (!self.textview.text.length) {
        [LCProgressHUD showFailure:@"请输入释义说明"];
        return;
    }
    [params setValue:@(self.taskId) forKey:@"taskId"];
    [params setValue:self.nameFidld.text forKey:@"brandName"];
    [params setValue:@(isCheck) forKey:@"isCheck"];
    [params setValue:self.textview.text forKey:@"reason"];
    
    DLog(@"%@",params);
    
[CBConnect getHomeTaskTouGao:params imageArray:array isNone:YES success:^(id responseObject) {
    [LCProgressHUD showSuccess:@"提交成功"];
    [self.navigationController popViewControllerAnimated:YES];
   } successBackfailError:^(id responseObject) {
    
   } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
