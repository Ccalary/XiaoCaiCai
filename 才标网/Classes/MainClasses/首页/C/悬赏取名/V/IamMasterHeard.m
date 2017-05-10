//
//  IamMasterHeard.m
//  才标网
//
//  Created by baichun on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterHeard.h"
#import "EditpageCell.h"
@interface IamMasterHeard ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *textFd;
@property (nonatomic,strong) UILabel *explainFD;
@property (nonatomic,strong) NSMutableArray *imageArray;

@end


@implementation IamMasterHeard

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self drawView];
    }
    
    return self;
}

- (NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(void)drawView{

    UIView *linewView = [[UIView alloc]init];
    linewView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:linewView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.text = @"名称:";
    [self.contentView addSubview:titleLabel];

    self.textFd = [[UILabel alloc]init];
    _textFd.font = [UIFont systemFontOfSize:15*UIRate];
    _textFd.text = @"234";
    _textFd.textColor = COLOR_Gray;
    [self.contentView addSubview:_textFd];

    UILabel *titleLabel1 = [[UILabel alloc]init];
    titleLabel1.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel1.text = @"释义:";
    titleLabel1.numberOfLines = 0;
    [self.contentView addSubview:titleLabel1];


    self.editorBtn = [[UIButton alloc]init];
    [_editorBtn setImage:[UIImage imageNamed:@"IamMaster_bianji"] forState:UIControlStateNormal];
    [_editorBtn addTarget:self action:@selector(editorbtn) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_editorBtn];

    self.deleteBtn = [[UIButton alloc]init];
    [_deleteBtn setImage:[UIImage imageNamed:@"IamMaster_del"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deletebtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];


    self.explainFD = [[UILabel alloc]init];
    _explainFD.font = [UIFont systemFontOfSize:15*UIRate];
    _explainFD.text = @"123";
    _explainFD.textColor = COLOR_Gray;
    [self.contentView addSubview:_explainFD];
    
    
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
    
    linewView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(20*UIRate)
    .topSpaceToView(self.contentView,0);
    
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(linewView,10*UIRate)
    .widthIs(45*UIRate)
    .heightIs(20*UIRate);
    
    _textFd.sd_layout
    .leftSpaceToView(titleLabel,5*UIRate)
    .widthIs(200*UIRate)
    .topSpaceToView(linewView,10*UIRate)
    .heightIs(20*UIRate);
    
    titleLabel1.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titleLabel,10*UIRate)
    .widthIs(45*UIRate)
    .heightIs(20*UIRate);
    
    
    _explainFD.sd_layout
    .leftSpaceToView(titleLabel1,5*UIRate)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(titleLabel,10*UIRate)
    .heightIs(20*UIRate);
    
    _editorBtn.sd_layout
    .leftSpaceToView(_textFd,30*UIRate)
    .topSpaceToView(linewView,10*UIRate)
    .widthIs(30*UIRate)
    .heightIs(20*UIRate);
    
    _deleteBtn.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(linewView,10*UIRate)
    .widthIs(40*UIRate)
    .heightIs(20*UIRate);
    
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titleLabel1,1)
    .rightSpaceToView(self.contentView,15*UIRate)
    .bottomEqualToView(self.contentView);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
}

-(void)editorbtn{
    
    if (self.editorblock) {
        self.editorblock();
    }
}

-(void)deletebtn{
    if (self.delectblock) {
        self.delectblock();
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
    self.textFd.text = model.brandName;
    self.explainFD.text = model.reason;
    
    [self.imageArray  removeAllObjects];
    for (int i=0; i<model.picPaths.count; i++) {
        NSString *str  = [NSString stringWithFormat:@"%@",IMAGE_URL(model.picPaths[i])];
        [self.imageArray addObject:str];
    }

    [self.mCollectionView reloadData];
}

@end
