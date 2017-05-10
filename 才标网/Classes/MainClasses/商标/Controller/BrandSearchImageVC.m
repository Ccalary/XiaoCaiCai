//
//  BrandSearchImageVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchImageVC.h"
#import "TZImagePickerController.h"
#import "BrandSearchResultVC.h"
#import "CBConnect.h"
#import "BrandSearchModel.h"
#import "LoginViewController.h"
#import "UserHelper.h"
@interface BrandSearchImageVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)UIImageView *brandImageView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation BrandSearchImageVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图形检索";
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"图形检索";
    textlabel.font = SYSTEM_FONT_(18*UIRate);
    textlabel.textColor = COLOR_Black;
    [self.view addSubview:textlabel];
    
    UIButton *imageBtn = [[UIButton alloc] init];
    [imageBtn setTitle:@"点击按钮上传图片" forState:UIControlStateNormal];
    [imageBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [imageBtn setImage:[UIImage imageNamed:@"brand_s_camera_60x60"] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(imageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageBtn];
    
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    _brandImageView.layer.borderWidth = 1;
    _brandImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_brandImageView];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    searchBtn.backgroundColor = COLOR_OrangeLight;
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    textlabel.sd_layout
    .leftSpaceToView(self.view, 15*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _brandImageView.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,50*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(240*UIRate);
    
    imageBtn.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(_brandImageView)
    .widthIs(200*UIRate)
    .heightIs(150*UIRate);
    
    [imageBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10*UIRate];

    searchBtn.sd_layout
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_brandImageView,20*UIRate)
    .widthIs(65*UIRate)
    .heightIs(40*UIRate);
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
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isBool) {
        self.brandImageView.image = photos.firstObject;
        [self.dataArray removeAllObjects];
        [self.dataArray addObject:photos.firstObject];
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
    
    self.brandImageView.image = image;
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:image];

}

#pragma mark - Action
- (void)imageBtnAction{
    
    [self addPhoto];
}

//搜索
- (void)searchBtnAction{
    
   
    if (!self.dataArray.count){
        [LCProgressHUD showMessage:@"请上传图片"];
        return;
    }
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }

        BrandSearchResultVC *vc = [[BrandSearchResultVC alloc] init];
        vc.imageViewArray = self.dataArray;
        [self.navigationController pushViewController:vc animated:YES];
}

@end
