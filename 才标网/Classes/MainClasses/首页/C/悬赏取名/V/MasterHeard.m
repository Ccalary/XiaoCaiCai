//
//  MasterHeard.m
//  才标网
//
//  Created by baichun on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MasterHeard.h"
#import "EditpageCell.h"
@interface MasterHeard ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *mCollectionView;

@property (nonatomic,strong) NSMutableArray *imageArray;

@end


@implementation MasterHeard
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        [self drawView];
    }
    
    return self;
}

-(void)drawView{
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"名称：辉格";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    UIButton *registeredBtn = [[UIButton alloc]init];
    [registeredBtn addTarget:self action:@selector(registeredBtn) forControlEvents:UIControlEventTouchUpInside];
    [registeredBtn setTitle:@"注册商标" forState:UIControlStateNormal];
    [registeredBtn.layer setBorderWidth:1];//设置边界的宽度
    registeredBtn.layer.borderColor = COLOR_ButtonBackGround_Blue.CGColor;
    [registeredBtn setTitleColor:COLOR_ButtonBackGround_Blue forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
//    registeredBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:registeredBtn];
    
    
    CGFloat ItemWidth = (ScreenWidth - 40*UIRate)/4.0-10;
    CGFloat ItemHeight = 65*UIRate;
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
    _mCollectionView.scrollEnabled = NO;
    
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_mCollectionView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];

    
    self.explainLabel = [[UILabel alloc] init];
    _explainLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _explainLabel.textColor = HEXCOLOR(0x333333);
    _explainLabel.text = @"释义：光辉有格调";
    _explainLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_explainLabel];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(30*UIRate)
    .widthIs(280*UIRate);
    
    registeredBtn.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate)
    .widthIs(70*UIRate);
    
    registeredBtn.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _explainLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,5*UIRate)
    .heightIs(30*UIRate)
    .widthIs(300*UIRate);
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(_explainLabel,1)
    .rightSpaceToView(self.contentView,15*UIRate)
    .bottomEqualToView(self.contentView);
    
}


-(void)registeredBtn{
    
    if (self.regisblock) {
        self.regisblock();
    }
    
}
#pragma mark ========= CollectionView 协议 =============
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//cell的记载
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EditpageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.row]]];
    cell.delectBtn.hidden=YES;
    return cell;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setModel:(TaskTouGaoModel *)model
{
    _model = model;
       
    [self.imageArray  removeAllObjects];
    for (int i=0; i<model.picPaths.count; i++) {
        NSString *str  = [NSString stringWithFormat:@"%@",IMAGE_URL(model.picPaths[i])];
        [self.imageArray addObject:str];
    }
    
    [self.mCollectionView reloadData];
}


@end
