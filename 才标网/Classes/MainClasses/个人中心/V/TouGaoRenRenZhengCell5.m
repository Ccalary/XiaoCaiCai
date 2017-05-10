//
//  TouGaoRenRenZhengCell5.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengCell5.h"
#import "TZImagePickerController.h"

@interface TouGaoRenRenZhengCell5 ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *uploadLabel ;


@end

@implementation TouGaoRenRenZhengCell5


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

+ (TouGaoRenRenZhengCell5 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TouGaoRenRenZhengCell5";
    TouGaoRenRenZhengCell5 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TouGaoRenRenZhengCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"身份证认证";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    _uploadButton = [[UIButton alloc] init];
    _uploadButton.backgroundColor = COLOR_LineViewColor;
    _uploadButton.layer.cornerRadius = 15.0;
    
    [_uploadButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_uploadButton];
    
    self.uploadLabel = [[UILabel alloc]init];
    self.uploadLabel.text = @"+ 上传";
    self.uploadLabel.backgroundColor = COLOR_Gray;
    self.uploadLabel.font = [UIFont systemFontOfSize:16];
    self.uploadLabel.textAlignment = NSTextAlignmentCenter;
    self.uploadLabel.layer.cornerRadius = 15;
    self.uploadLabel.clipsToBounds = YES;
    self.uploadLabel.textColor = [UIColor whiteColor];
    [self.uploadButton addSubview:self.uploadLabel];
    
    _idImageView = [[UIImageView alloc] init];
    _idImageView.layer.cornerRadius = 15.0;
    [self.contentView addSubview:_idImageView];
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .heightIs(15);
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,20)
    .widthIs(100)
    .heightIs(20);
    
    _uploadButton.sd_layout
    .topSpaceToView(titleLabel,10)
    .centerXEqualToView(self.contentView)
    .widthIs(537/2)
    .heightIs(339/2);
    
    self.uploadLabel.sd_layout
    .centerXEqualToView(_uploadButton)
    .centerYEqualToView(_uploadButton)
    .widthIs(80*UIRate)
    .heightIs(30*UIRate);

    _idImageView.sd_layout
    .leftEqualToView(self.uploadButton)
    .rightEqualToView(self.uploadButton)
    .topEqualToView(self.uploadButton)
    .bottomEqualToView(self.uploadButton);
    
}
    
- (void)addPhoto
{
   LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil buttonTitles:@[@"相册", @"相机"] redButtonIndex:-1 delegate:nil];
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
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    ///是否 在相册中显示拍照按钮
    imagePickerVc.allowTakePicture = NO;
    ///是否可以选择显示原图
    imagePickerVc.allowPickingOriginalPhoto = NO;
    ///是否 在相册中可以选择视频
    imagePickerVc.allowPickingVideo = NO;
    
    [DCURLRouter presentViewController:imagePickerVc animated:YES completion:nil];
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
        [DCURLRouter presentViewController:picker animated:YES completion:nil];
    }else{
        
        [LCProgressHUD showInfoMsg:@"该设备不支持拍照"];
    }
}

#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    self.uploadLabel.hidden = YES;
    _idImageView.image = [photos firstObject];
    if (self.didChoosePtoto)
    {
        self.didChoosePtoto([photos firstObject]);
    }
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _idImageView.image = image;
    self.uploadLabel.hidden = YES;
    if (self.didChoosePtoto)
    {
        self.didChoosePtoto(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
