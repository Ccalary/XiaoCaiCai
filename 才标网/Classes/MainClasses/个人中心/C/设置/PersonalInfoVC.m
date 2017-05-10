//
//  PersonalInfoVC.m
//  才标网
//
//  Created by caohouhong on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "TZImagePickerController.h"
#import "ChangeNameVC.h"
#import "UserHelper.h"
#import "CBConnect.h"
@interface PersonalInfoVC()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic,strong)  NSString *nameString;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation PersonalInfoVC
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.dataArray = @[@"头像",@"名字"];
    [self drawView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.nameString = [UserHelper getMemberName];
    [self.mTableView reloadData];
}
-  (void)drawView
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:_mTableView];
    
    _mTableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .widthRatioToView(self.view, 1)
    .heightRatioToView(self.view, 1);
    
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = SYSTEM_FONT_(15*UIRate);
    nameLabel.textColor = COLOR_darkGray;
    nameLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:nameLabel];
    
    iconImageView.sd_layout
    .rightEqualToView(cell.contentView).offset(-5)
    .centerYEqualToView(cell.contentView)
    .widthIs(40*UIRate)
    .heightIs(40*UIRate);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    nameLabel.sd_layout
    .rightEqualToView(cell.contentView).offset(-5)
    .centerYEqualToView(cell.contentView)
    .widthIs(100)
    .heightRatioToView(cell.contentView,1);

    if (indexPath.row == 0){ //头像
        if (self.iconImage){
            iconImageView.image = self.iconImage;
        }else {
            NSString *userImage = [UserHelper getMemberHeaderPhoto];
            [iconImageView sd_setImageWithURL:[NSURL URLWithString:userImage] placeholderImage:[UIImage imageNamed:@"uc_default_header_60x60"]];
        }
        
        nameLabel.text = @"";
    }else if(indexPath.row == 1){
        iconImageView.image = [UIImage imageNamed:@""];
        nameLabel.text = _nameString;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 45*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        
    switch (indexPath.row) {
        case 0://头像
            [self addPhoto];
                break;
        case 1://名字
        {
            ChangeNameVC *vc = [[ChangeNameVC alloc] init];
            vc.namestring = [UserHelper getMemberName];
            [self.navigationController pushViewController:vc animated:YES];
        }
                break;
        default:
                break;
    }
    
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
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isBool) {
        weakSelf.iconImage = photos.firstObject;
        [weakSelf.imageArray removeAllObjects];
        [weakSelf.imageArray addObject:weakSelf.iconImage];
        [weakSelf.mTableView reloadData];
        [weakSelf requesData];
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
    
    self.iconImage = image;
    [self.imageArray removeAllObjects];
    [self.imageArray addObject:self.iconImage];
    [self.mTableView reloadData];
    
    [self requesData];
}

#pragma mark - ==========网络请求============
-(void)requesData{
    [LCProgressHUD showLoading:@"正在上传"];
    NSString *nameString = [UserHelper getMemberName];
   NSString *idString = [UserHelper getMemberId];
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:nameString forKey:@"firstname"];
    [parms setValue:idString forKey:@"memberId"];
    [CBConnect getUserMemberModifyMeber:parms imageArray:self.imageArray isNone:NO success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"上传成功"];
        [UserHelper setMemberHeaderPhoto:responseObject[@"portrait"]];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
