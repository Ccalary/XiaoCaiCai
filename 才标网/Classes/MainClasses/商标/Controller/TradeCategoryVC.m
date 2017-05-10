//
//  TradeCategoryVC.m
//  才标网
//
//  Created by caohouhong on 17/5/2.
//  Copyright © 2017年 李强. All rights reserved.
//  行业分类

#import "TradeCategoryVC.h"
#import "TradeCateCollectionViewCell.h"
#import "CBConnect.h"
#import "TradeMarkCategoryModel.h"

@interface TradeCategoryVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NSMutableArray *sidArray;
@property (nonatomic, strong) NSArray *colorArray;

@property (nonatomic, strong) NSArray *selectedArray; //已选中的

@end

@implementation TradeCategoryVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray){
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}

- (NSMutableArray *)sidArray
{
    if (!_sidArray){
        _sidArray = [[NSMutableArray alloc] init];
    }
    return _sidArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //颜色
    self.colorArray = @[HEXCOLOR(0x20c2eb),HEXCOLOR(0xfda328),HEXCOLOR(0x22d489),HEXCOLOR(0xfb6137)];
    self.navigationItem.title = @"行业分类";
    [self drawView];
    [self initFooterView];
    [self requestCateListTree];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    CGFloat ItemWidth = (ScreenWidth - 60)/3.0;
    CGFloat ItemHeight = 50*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 15*UIRate;
    aLayOut.minimumInteritemSpacing = 0;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[TradeCateCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.allowsMultipleSelection = YES;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topEqualToView(self.view)
    .bottomSpaceToView(self.view,70*UIRate);

}

- (void)initFooterView{
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(30*UIRate, ScreenHeight - 40*UIRate - 15*UIRate, (ScreenWidth - 120*UIRate)/2.0, 40*UIRate)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    cancelButton.tag = 10000;
    cancelButton.layer.cornerRadius = 4.0;
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor = COLOR_darkGray;
    [self.view addSubview:cancelButton];

    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2.0 + 30*UIRate, CGRectGetMinY(cancelButton.frame),CGRectGetWidth(cancelButton.frame), 40*UIRate)];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    sureButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    sureButton.tag = 10001;
    sureButton.layer.cornerRadius = 4.0;
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = COLOR_OrangeLight;
    [self.view addSubview:sureButton];
    
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
    TradeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    //选中
    if ([@"1" isEqualToString:self.selectArray[indexPath.row]]){
        int x = arc4random() % 4;
        if (self.colorArray.count > x){
            cell.contentView.backgroundColor = self.colorArray[x];
        }
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = COLOR_darkGray;
    }
    
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5*UIRate, 15*UIRate, 5*UIRate, 15*UIRate);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    //选中
    if ([@"1" isEqualToString:self.selectArray[indexPath.row]]){
       [self.selectArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }else {
        [self.selectArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    
    //局部cell刷新
    NSIndexPath *position = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.mCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:position,nil]];
}

#pragma mark - Action 
- (void)btnAction:(UIButton *)button{
    
    if (button.tag == 10000){//取消
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < self.selectArray.count; i++){
            [array addObject:@"0"];
        }
    
        [self.selectArray removeAllObjects];
        [self.selectArray addObjectsFromArray:array];
        [self.mCollectionView reloadData];
        
    }else if (button.tag == 10001) {//确认
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int i = 0 ; i < self.selectArray.count; i++){
            if ([@"1" isEqualToString:self.selectArray[i]]){
                [array addObject:self.sidArray[i]];
            }
        }
        
        NSString *string = [array componentsJoinedByString:@","];
        
        if (self.block){
            self.block(string);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ========网络请求，请求行业=========

//商标起名行业列表
- (void)requestCateListTree{
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [CBConnect getHomeListCateTree:params success:^(id responseObject) {
        
        [self.dataArray removeAllObjects];
        
        NSArray *array = [TradeMarkCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        //字符串转数组
        self.selectedArray = [self.selectedStr componentsSeparatedByString:@","];
        DLog(@"%@",self.selectedArray);
        
        for (TradeMarkCategoryModel *model in array){
            
            NSString *str = [NSString stringWithFormat:@"%@ %@",model.category_number, model.category_name];
            [self.dataArray addObject:str];
            [self.sidArray addObject:model.category_number?:@""];
            BOOL isAdd = NO;
            for (NSString *str in self.selectedArray){
                if ([str isEqualToString:model.category_number?:@""]){
                    [self.selectArray addObject:@"1"];
                    isAdd = YES;
                    break;
                }
            }
            if (!isAdd){
                [self.selectArray addObject:@"0"];
            }
        }
        
        [self.mCollectionView reloadData];
        
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
