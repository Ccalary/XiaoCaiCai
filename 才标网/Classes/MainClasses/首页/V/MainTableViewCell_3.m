//
//  MainTableViewCell_3.m
//  才标网
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainTableViewCell_3.h"
#import "MainCollectionViewCell.h"
#import "MainCollectionViewLayout.h"

@interface MainTableViewCell_3()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@end

@implementation MainTableViewCell_3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTableViewCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTableViewCell_3";
    MainTableViewCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTableViewCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    CGFloat ItemWidth = 230*UIRate;
    CGFloat ItemHeight = 325*UIRate;
    MainCollectionViewLayout * aLayOut = [[MainCollectionViewLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;

    _mCollectionView.showsHorizontalScrollIndicator = NO;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,10*UIRate)
    .bottomSpaceToView(self,10*UIRate);
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
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5*UIRate, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ModelMember *model = self.dataArray[indexPath.row];
    
    if (self.block){
        self.block(model);
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.mCollectionView reloadData];
    
     if (dataArray.count > 2){
    //代码执行一次
    static dispatch_once_t disOnce;
    dispatch_once(&disOnce,  ^ {
       [_mCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
     }
}

@end
