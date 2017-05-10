//
//  SearchViewController.m
//  才标网
//
//  Created by caohouhong on 17/4/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SearchViewController.h"
#import "BrandCategoryVC.h"
#import "TZImagePickerController.h"
#import "LoginViewController.h"
#import "UserHelper.h"
#import "BrandSearchResultVC.h"
#import "BaseWebViewController.h"
#import "CBConnect.h"
#import "VersionModel.h"
#import "listDictiionaryItemsModel.h"
#define BRAND_CATE_DEFAULT_URL @"http://www.58caibiao.com/?route=trademark/search/interclassif"

@interface SearchViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITextField *textField;

@end

@implementation SearchViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawView];
    
    [self requestVersionUpdata];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
     self.textField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    UIImageView *imageViewBg = [[UIImageView alloc] init];
    imageViewBg.image = [UIImage imageNamed:@"s_bg"];
    
    UILabel *textLabel1 = [[UILabel alloc] init];
    textLabel1.font = SYSTEM_FONT_(15*UIRate);
    textLabel1.textColor = [UIColor whiteColor];
    textLabel1.text = @"一秒知天下，三分钟轻松注册";
    textLabel1.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *codeImageView = [[UIImageView alloc] init];
    codeImageView.image = [UIImage imageNamed:@"s_small_bg_375x170"];
    
    UILabel *textLabel2 = [[UILabel alloc] init];
    textLabel2.font = SYSTEM_FONT_BOLD_(18*UIRate);
    textLabel2.textColor = [UIColor whiteColor];
    textLabel2.text = @"文字图形检索";
    textLabel2.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"s_searchbar_324x43"];
    
    UIButton *cameraButton = [[UIButton alloc]init];
    [cameraButton setImage:[UIImage imageNamed:@"s_camera_25x20"] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *searchButton = [[UIButton alloc]init];
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    searchButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];

    _textField = [[UITextField alloc] init];
    _textField.font = SYSTEM_FONT_(15*UIRate);
    _textField.textColor = COLOR_darkGray;
    _textField.placeholder = @"请输入商标或上传图形";
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.delegate = self;
    
    UIButton *cateButton = [[UIButton alloc]init];
    [cateButton setTitle:@"商标分类" forState:UIControlStateNormal];
    [cateButton setImage:[UIImage imageNamed:@"s_cate_22x22"] forState:UIControlStateNormal];
    cateButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [cateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cateButton addTarget:self action:@selector(cateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [cateButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft
                          imageTitleSpace:10*UIRate];
    
    [self.view sd_addSubviews:@[imageViewBg,textLabel1, codeImageView,textLabel2, searchImageView, cameraButton, searchButton, _textField, cateButton]];
    
    imageViewBg.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    textLabel1.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, 170*UIRate)
    .heightIs(15*UIRate);
    
    codeImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,215*UIRate)
    .widthRatioToView(self.view,1)
    .heightIs(170*UIRate);
    
    textLabel2.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(codeImageView).offset(28*UIRate)
    .heightIs(20*UIRate);
    
    searchImageView.sd_layout
    .centerXEqualToView(self.view)
    .topEqualToView(codeImageView).offset(75*UIRate)
    .widthIs(324*UIRate)
    .heightIs(43*UIRate);
    
    cameraButton.sd_layout
    .centerYEqualToView(searchImageView)
    .rightEqualToView(searchImageView).offset(-60*UIRate)
    .widthIs(45*UIRate)
    .heightRatioToView(searchImageView,1);
    
    searchButton.sd_layout
    .centerYEqualToView(searchImageView)
    .rightEqualToView(searchImageView)
    .widthIs(60*UIRate)
    .heightRatioToView(searchImageView,1);
 
    _textField.sd_layout
    .centerYEqualToView(searchImageView)
    .leftEqualToView(searchImageView).offset(10*UIRate)
    .widthIs(200*UIRate)
    .heightRatioToView(searchImageView,1);
    
    cateButton.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,75*UIRate)
    .widthIs(200*UIRate)
    .heightIs(30*UIRate);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchButtonAction];
    return YES;
}

//查询
- (void)searchButtonAction{

    [self.view endEditing:YES];
    
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    
    if (self.textField.text.length==0){
        [LCProgressHUD showMessage:@"请输入要搜索的内容"];
        return;
    }
    
    BrandSearchResultVC *vc = [[BrandSearchResultVC alloc] init];
    vc.mTextField = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
}

//拍照
- (void)cameraButtonAction{
    [self.view endEditing:YES];
    
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    [self addPhoto];
}

//商标分类
- (void)cateButtonAction{

    BaseWebViewController *webVC = [[BaseWebViewController alloc] initWithTitle:@"商标分类" andUrl:BRAND_CATE_DEFAULT_URL];
    webVC.isCanGoBack = NO;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)addPhoto
{
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil buttonTitles:@[@"上传照片", @"拍照"] redButtonIndex:-1 delegate:nil];
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
    __weak typeof (self) weakSelf = self;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isBool) {
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObject:photos.firstObject];
        [weakSelf imageSearchBtnAction];

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
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:image];
    [self imageSearchBtnAction];
}

//图片搜索
- (void)imageSearchBtnAction{
    
    
    BrandSearchResultVC *vc = [[BrandSearchResultVC alloc] init];
    vc.imageViewArray = self.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - =======版本更新网络请求=======
- (void)requestVersionUpdata {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //去掉获得的版本号的小数点
    NSString *versionBuild = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(2) forKey:@"deviceType"]; //1-安卓 2-iOS
    [params setValue:versionBuild forKey:@"build"];
    
    [CBConnect getOtherGetVersionInfo:params success:^(id responseObject) {
        VersionModel *model = [VersionModel mj_objectWithKeyValues:responseObject];
        //0-不更新  1- 更新  2- 强制更新
        if (model.updateState == 1){
            [self isEnForseUpdateWithNewVersion:NO andURL:model.downLoadPath andTips:model.versionDesc];
        }else if (model.updateState == 2){
            [self isEnForseUpdateWithNewVersion:YES andURL:model.downLoadPath andTips:model.versionDesc];
        }
        
    } successBackfailError:^(id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)isEnForseUpdateWithNewVersion:(BOOL) isEnForse andURL:(NSString *)url andTips:(NSString *)tipsStr{ //是否强制
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"版本更新" message:tipsStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    }];
    [alertController addAction:done];
    
    if (!isEnForse){
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancel];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark =================客服的网络请求===================
- (void)requestData{
    
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:@"dg_kefu_link" forKey:@"groupCode"];
    
    [CBConnect getVersionlistDictiionaryItems:parms success:^(id responseObject) {
        
        NSArray *array = [listDictiionaryItemsModel mj_objectArrayWithKeyValuesArray:responseObject];
        for (listDictiionaryItemsModel *model in array){
          [UserHelper setServiceUrl:[NSString stringWithFormat:@"%@",model.itemContent]];
        }
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
}
@end
