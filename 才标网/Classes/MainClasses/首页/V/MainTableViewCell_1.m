//
//  MainTableViewCell_1.m
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainTableViewCell_1.h"
#import "SDCycleScrollView.h"

#import "BaseWebViewController.h"

@interface MainTableViewCell_1 ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView *advScrollView;
@property (nonatomic, strong)NSMutableArray *imageArray;

@end

@implementation MainTableViewCell_1

- (NSMutableArray *)imageArray
{
    if (!_imageArray){
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTableViewCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTableViewCell_1";
    MainTableViewCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTableViewCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    _advScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 210*UIRate)  delegate:self placeholderImage:[UIImage imageNamed:@"home_banner_default_375x208"]];
    _advScrollView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof (self) weakSelf = self;
    _advScrollView.clickItemOperationBlock  = ^(NSInteger i){
        DLog(@"点击了第%ld张图片",(long)i);
        HomeAdsModel *model = (weakSelf.adsArray.count) ? weakSelf.adsArray[i] : nil;
        if (weakSelf.block){
            weakSelf.block(model);
        }
    };
    _advScrollView.autoScrollTimeInterval = 3.0f;
    _advScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    [self addSubview:_advScrollView];
}

- (void)setAdsArray:(NSArray *)adsArray{
    
    _adsArray = adsArray;
    
    [self.imageArray removeAllObjects];
    for (HomeAdsModel *model in adsArray){
     
        [self.imageArray addObject: IMAGE_URL(model.adImg?:@"")];
    }
    _advScrollView.imageURLStringsGroup = self.imageArray;
}

@end
