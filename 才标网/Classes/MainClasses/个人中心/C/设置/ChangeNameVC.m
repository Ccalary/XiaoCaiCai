//
//  ChangeNameVC.m
//  才标网
//
//  Created by caohouhong on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ChangeNameVC.h"
#import "CBConnect.h"
#import "UserHelper.h"
@interface ChangeNameVC ()
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation ChangeNameVC
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改名字";
    //测试
    UIImage *im = [UIImage imageNamed:@"icon_xiala2"];
    [_imageArray addObject:im];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 45*UIRate)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth - 30, 45*UIRate)];
    nameTextField.font = SYSTEM_FONT_(15);
    nameTextField.textColor = COLOR_darkGray;
    nameTextField.placeholder = @"请输入您的名字";
    nameTextField.text = self.namestring;
    [nameTextField addTarget:self action:@selector(textfieldAction:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:nameTextField];
    
    [nameTextField becomeFirstResponder];
}

- (void)textfieldAction:(UITextField *)textField{
    if (textField.text.length > 20){
        textField.text = [textField.text substringToIndex:20];
    }
    self.namestring = textField.text;
}

//完成按钮
- (void)rightBarAction {
    [self.view endEditing:YES];
    [self requesData];
}
#pragma mark =============网络请求===============
-(void)requesData{
    if (!self.namestring) {
        [LCProgressHUD showMessage:@"名字不能为空"];
        return;
    }
    [LCProgressHUD showLoading:@"正在修改"];
    NSString *idString = [UserHelper getMemberId];
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:_namestring forKey:@"firstname"];
    [parms setValue:idString forKey:@"memberId"];
    [CBConnect getUserMemberModifyMeber:parms imageArray:self.imageArray isNone:YES success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"修改成功"];
        [UserHelper setMemberName:responseObject[@"memberName"]];
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

    

@end
