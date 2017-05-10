//
//  RegisterTrademarkVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RegisterTrademarkVC.h"
#import "WithdrawTableViewCell.h"
#import "TZImagePickerController.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import "ToolsHelper.h"
#import "queryVC.h"
@interface RegisterTrademarkVC ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *placeholderArray;
@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *str2;
@property (nonatomic, strong) NSString *str3;
@property (nonatomic, strong) UILabel *upLabel;
@end

@implementation RegisterTrademarkVC
-(NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册商标";
    
    self.dataArray = @[@"商标名称",@"产品",@"联系人",@"联系电话"];
    self.placeholderArray = @[@"请输入您需要注册的商标名称(必填)",@"请输入您需要注册的产品",@"请输入您的姓名(必填)",@"请输入您的电话(必填)"];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)drawView{

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    tableView.tableFooterView = self.bottomView;
    [self.view addSubview:tableView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}


- (UIView *)bottomView
{
    if (!_bottomView){
        
       _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300*UIRate)];
        
       _bottomView.backgroundColor = COLOR_BackgroundColor;
        
        UILabel *uploadLabel = [[UILabel alloc] init];
        uploadLabel.text = @"营业执照:";
        uploadLabel.textColor = COLOR_Black;
        uploadLabel.font = SYSTEM_FONT_(15*UIRate);
        [_bottomView addSubview:uploadLabel];
        

        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.backgroundColor = COLOR_LightGray;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _photoImageView.userInteractionEnabled = YES;
        _photoImageView.layer.cornerRadius = 15;
        _photoImageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadBtnAction)];
        [_photoImageView addGestureRecognizer:singleTap1];
        [_bottomView addSubview:_photoImageView];
        
        self.upLabel = [[UILabel alloc]init];
        _upLabel.text = @"+ 上传";
        _upLabel.backgroundColor = COLOR_Gray;
        _upLabel.font = [UIFont systemFontOfSize:16*UIRate];
        _upLabel.textAlignment = NSTextAlignmentCenter;
        _upLabel.layer.cornerRadius = 15;
        _upLabel.clipsToBounds = YES;
        _upLabel.textColor = [UIColor whiteColor];
        [self.photoImageView addSubview:_upLabel];
        
        UIButton *registerBtn = [[UIButton alloc] init];
        [registerBtn setTitle:@"申请注册" forState:UIControlStateNormal];
        registerBtn.backgroundColor = COLOR_ButtonBackGround_Blue;
        registerBtn.layer.cornerRadius = 4.0;
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:registerBtn];
        
        UIButton *changeBtn = [[UIButton alloc] init];
        [changeBtn setTitle:@"复查" forState:UIControlStateNormal];
        changeBtn.backgroundColor = COLOR_ButtonBackGround_Blue;
        changeBtn.layer.cornerRadius = 4.0;
        [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:changeBtn];
        
        
        uploadLabel.sd_layout
        .leftSpaceToView(_bottomView, 15*UIRate)
        .topSpaceToView(_bottomView, 15*UIRate)
        .widthIs(80*UIRate)
        .heightIs(15*UIRate);
        
        _photoImageView.sd_layout
        .leftSpaceToView(_bottomView, 50*UIRate)
        .topSpaceToView(uploadLabel,15*UIRate)
        .widthIs(ScreenWidth - 100*UIRate)
        .heightIs(120*UIRate);
        
        _upLabel.sd_layout
        .centerXEqualToView(_photoImageView)
        .centerYEqualToView(_photoImageView)
        .widthIs(100*UIRate)
        .heightIs(35*UIRate);
        
        registerBtn.sd_layout
        .leftSpaceToView(_bottomView, 15*UIRate)
        .topSpaceToView(_photoImageView, 20*UIRate)
        .widthIs((ScreenWidth - 60*UIRate)/2.0)
        .heightIs(40*UIRate);
        
        changeBtn.sd_layout
        .rightSpaceToView(_bottomView, 15*UIRate)
        .centerYEqualToView(registerBtn)
        .widthRatioToView(registerBtn,1)
        .heightIs(40*UIRate);
        
    }
    return _bottomView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    WithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[WithdrawTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    cell.rightTextField.placeholder = self.placeholderArray[indexPath.row];
    
    cell.rightTextField.tag = indexPath.row + 10000;
    [cell.rightTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 3){
        cell.rightTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        cell.rightTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    if (indexPath.row == 0){
        cell.rightTextField.text = self.nameStr;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


#pragma mark - 图片处理
- (void)addPhoto
{
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil buttonTitles:@[@"照片", @"拍照"] redButtonIndex:-1 delegate:nil];
    [sheet show];
    
    __weak typeof(self) weakSelf = self;
    sheet.didClickedButtonAtIndex = ^(NSInteger buttonIndex,NSString *title){
        if (buttonIndex == 0) {
            [weakSelf openAlbum];
        }else{
            [weakSelf openCamera];
        }
    };
}

/** 相册 */
- (void)openAlbum {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    ///是否 在相册中显示拍照按钮
    imagePickerVc.allowTakePicture = NO;
    ///是否可以选择显示原图
    imagePickerVc.allowPickingOriginalPhoto = NO;
    ///是否 在相册中可以选择视频
    imagePickerVc.allowPickingVideo = NO;
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isBool) {
        self.photoImageView.image = photos.firstObject;
        _upLabel.hidden = YES;
        [self.imageViewArray addObject:self.photoImageView.image];
        self.photoImageView.backgroundColor = [UIColor clearColor];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


/** 相机 */
- (void)openCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        [LCProgressHUD showInfoMsg:@"该设备不支持拍照"];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.photoImageView.image = image;
    [self.imageViewArray addObject:image];
    _upLabel.hidden = YES;
    self.photoImageView.backgroundColor = [UIColor clearColor];
}


#pragma mark - Action


- (void)textFieldAction: (UITextField *)textField
{
    switch (textField.tag) {
        case 10000:
        {
            self.nameStr = textField.text;
        }
            break;
        case 10001:
        {
            self.str1 = textField.text;
        }
            break;
        case 10002:
        {
            self.str2 = textField.text;
        }
            break;
        case 10003:
        {
            self.str3 = textField.text;
        }
            break;
        default:
            break;
    }
}

//上传
- (void)uploadBtnAction{
    [self addPhoto];
}

//申请注册
- (void)registerBtnAction{
    
   
    if (self.nameStr.length == 0) {
        [LCProgressHUD showMessage:@"请输入商标名称"];
        return;
    }
    if (self.str2.length == 0) {
        [LCProgressHUD showMessage:@"请输入姓名"];
        return;
    }
    if (self.str3.length != 11) {
        [LCProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.str2 forKey:@"customer_name"];
    [params setValue:self.str3 forKey:@"customer_telephone"];
    [params setValue:self.nameStr forKey:@"trademark_name"];
    [params setValue:self.str1 forKey:@"remarks"];
    
    if (self.imageViewArray.count>0) {
        [CBConnect getTradeMarkApply:params imageArray:self.imageViewArray isNone:NO success:^(id responseObject) {
            [LCProgressHUD showSuccess:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }else{
        [CBConnect getTradeMarkApply:params imageArray:self.imageViewArray isNone:YES success:^(id responseObject) {
            [LCProgressHUD showSuccess:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];

        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];

    }
    

}
//复查
- (void)checkBtnAction{
    queryVC *vc = [[queryVC alloc]init];
    vc.nameString = [self.nameStr copy];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
