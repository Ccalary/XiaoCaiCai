//
//  EditpageVC.m
//  才标网
//
//  Created by baichun on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "EditpageVC.h"
#import "EditpageCell.h"
#import "TZImagePickerController.h"
#import "UserHelper.h"
#import "CBConnect.h"
#import <QuartzCore/QuartzCore.h>

@interface EditpageVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITextField *textFd;
@property (nonatomic, strong) UITextView *explainFD;
@property (nonatomic, strong) UILabel *titleLabel2;
@end

@implementation EditpageVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑投稿";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnAction)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.text = @"名称:";
    [self.view addSubview:titleLabel];
    
    self.textFd = [[UITextField alloc]init];
    _textFd.font = [UIFont systemFontOfSize:15*UIRate];
    _textFd.placeholder = @"输入商标名字";
    _textFd.text = self.model.brandName;
    [self.view addSubview:_textFd];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:lineView];
    
    UILabel *titleLabel1 = [[UILabel alloc]init];
    titleLabel1.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel1.text = @"释义:";
    titleLabel1.numberOfLines = 0;
    [self.view addSubview:titleLabel1];
    
    self.titleLabel2 = [[UILabel alloc]init];
    _titleLabel2.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel2.text = @"选择释义图片";
    _titleLabel2.numberOfLines = 0;
    [self.view addSubview:_titleLabel2];
    
     self.explainFD = [[UITextView alloc]init];
    _explainFD.font = [UIFont systemFontOfSize:15*UIRate];
    _explainFD.placeholder = @"输入释义详情";
    _explainFD.text = self.model.reason;
    _explainFD.layer.borderColor = COLOR_LightGray.CGColor;
    _explainFD.layer.borderWidth =1.0;
    _explainFD.layer.cornerRadius =5.0;

    [self.view addSubview:_explainFD];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:lineView1];
    
   
    titleLabel.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,15*UIRate)
    .heightIs(30*UIRate)
    .widthIs(40*UIRate);
    
    _textFd.sd_layout
    .leftSpaceToView(titleLabel,5*UIRate)
    .topEqualToView(titleLabel)
    .heightIs(30*UIRate)
    .rightSpaceToView(self.view,15*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(titleLabel,5*UIRate)
    .heightIs(1);
    
    titleLabel1.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .heightIs(30*UIRate)
    .widthIs(40*UIRate);
    

    _explainFD.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(titleLabel1,5*UIRate)
    .heightIs(80*UIRate);
       
    _titleLabel2.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_explainFD,5*UIRate)
    .heightIs(30*UIRate);
    
    [self drawView];
}
- (void)drawView{
   
    
    UIImage *ima = [UIImage imageNamed:@"IamMaster_shangchuanzhaopian"];
    [self.dataArray insertObject:ima atIndex:0];
    if (self.model.picPaths.count>0) {
        for (int i = 0; i<self.model.picPaths.count; i++) {
        
            NSString *imageUrl = [NSString stringWithFormat:@"%@",IMAGE_URL(self.model.picPaths[i])];
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            [self.dataArray insertObject:imageView.image atIndex:0];
            
        }
        
    }
    
    CGFloat ItemWidth = 75*UIRate;
    CGFloat ItemHeight = 75*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 5*UIRate;
    aLayOut.minimumInteritemSpacing = 4*UIRate;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[EditpageCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_titleLabel2,20*UIRate)
    .bottomSpaceToView(self.view,0);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//cell的记载
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EditpageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    if (indexPath.row==self.dataArray.count-1) {
        cell.ImageView.image = self.dataArray[indexPath.row];
        cell.delectBtn.hidden=YES;
    }else{
        cell.delectBtn.hidden=NO;
//        [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",IMAGE_URL(self.model.picPaths[indexPath.row])]]];
        cell.ImageView.image = self.dataArray[indexPath.row];

    }
    cell.delectblock = ^(){
      //执行删除操作
        DLog(@"@@@@@@@@@@@@@%ld",(long)indexPath.row);
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.mCollectionView reloadData];
    };
    return cell;
}





//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.dataArray.count-1) {
        
        [self addPhoto];
        
    }
    DLog(@"%ld",(unsigned long)self.dataArray.count);
    DLog(@"%ld",(long)indexPath.row);
   
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
        UIImage *image = photos.firstObject;
        [self.dataArray insertObject:image atIndex:0];
        DLog(@"%ld",(unsigned long)self.dataArray.count);
        [self.mCollectionView reloadData];

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
    
    [self.dataArray insertObject:image atIndex:0];
    DLog(@"%ld",(unsigned long)self.dataArray.count);
    [self.mCollectionView reloadData];
}


#pragma mark ============  编辑投稿数据提交 =============

-(void)rightBarBtnAction{
    [LCProgressHUD showLoading:@"提交中"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.textFd.text forKey:@"brandName"];
    [params setValue:self.explainFD.text forKey:@"reason"];
    [params setValue:@(self.TouGaoId) forKey:@"touGaoId"];
 
        DLog(@"%@",params);
    if (self.dataArray.count>1) {
        [self.dataArray removeObjectAtIndex:self.dataArray.count-1];
        [CBConnect getModifTouGao:params imageArray:self.dataArray isNone:NO success:^(id responseObject) {
            [LCProgressHUD showSuccess:@"编辑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }else{
        [CBConnect getModifTouGao:params imageArray:self.dataArray isNone:YES success:^(id responseObject) {
            [LCProgressHUD showSuccess:@"编辑成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
