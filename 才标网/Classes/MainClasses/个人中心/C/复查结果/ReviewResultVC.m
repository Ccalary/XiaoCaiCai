//
//  ReviewResultVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReviewResultVC.h"
#import "queryVC.h"
#import "MyOrderScrollView.h"
#import "ReviewListView.h"
#import "ReviewResultDetailVC.h"

@interface ReviewResultVC ()<UIScrollViewDelegate,ReviewListViewDelegate>
@property (nonatomic, strong) MyOrderScrollView *mScrollView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIView *indicatorView;
@end

@implementation ReviewResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商标复查";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawSearchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawSearchView{
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"home_search"];// 280x37
    [self.view addSubview:searchImageView];
    
    self.textField = [[UITextField alloc] init];
    _textField.font = SYSTEM_FONT_(16*UIRate);
    _textField.textColor = COLOR_darkGray;
    _textField.placeholder = @"请输入商标名称";
    [self.view addSubview:_textField];
    self.searchButton = [[UIButton alloc] init];
    _searchButton.titleLabel.font = SYSTEM_FONT_(16*UIRate);
    [_searchButton setTitle:@"复查" forState:UIControlStateNormal];
    _searchButton.layer.cornerRadius = 4.0;
    [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchButton setBackgroundColor:HEXCOLOR(0x397fff)];
    [_searchButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:dividerView];
    
    searchImageView.sd_layout
    .leftSpaceToView(self.view, 10*UIRate)
    .topSpaceToView(self.view,20*UIRate)
    .widthIs(ScreenWidth - 95*UIRate)
    .heightIs(37*UIRate);
    
    _textField.sd_layout
    .leftEqualToView(searchImageView).offset(50*UIRate)
    .centerYEqualToView(searchImageView)
    .widthIs(ScreenWidth - 150*UIRate)
    .heightRatioToView(searchImageView,1);
    
    _searchButton.sd_layout
    .leftSpaceToView(searchImageView,10*UIRate)
    .centerYEqualToView(searchImageView)
    .widthIs(65*UIRate)
    .heightRatioToView(searchImageView,1);
    
    dividerView.sd_layout
    .topSpaceToView(searchImageView,20*UIRate)
    .centerXEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(20*UIRate);
    /************按钮***********/
    UIButton *allButton = [self creatButtonWithTitle:@"全部"];
    allButton.tag = 10000;
    UIButton *doingButton = [self creatButtonWithTitle:@"进行中"];
    doingButton.tag = 10001;
    UIButton *doneButton = [self creatButtonWithTitle:@"已结束"];
    doneButton.tag = 10002;
    
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 144*UIRate, ScreenWidth/3.0, 3*UIRate)];
    _indicatorView.backgroundColor = COLOR_Orange;
    [self.view addSubview:_indicatorView];
    
    [self.view sd_addSubviews:@[allButton, doingButton, doneButton]];
    
    doingButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(dividerView,0)
    .widthIs(ScreenWidth/3.0)
    .heightIs(50*UIRate);
    
    allButton.sd_layout
    .leftEqualToView(self.view)
    .centerYEqualToView(doingButton)
    .widthIs(ScreenWidth/3.0)
    .heightIs(50*UIRate);
    
    doneButton.sd_layout
    .rightEqualToView(self.view)
    .centerYEqualToView(doingButton)
    .widthIs(ScreenWidth/3.0)
    .heightIs(50*UIRate);
    
    /***********scrollView***********/
    _mScrollView = [[MyOrderScrollView alloc] initWithFrame:CGRectMake(0, 147*UIRate, ScreenWidth, ScreenHeight - 147*UIRate)];
    _mScrollView.delegate = self;
    [self.view addSubview:_mScrollView];
    
    ReviewListView *listView1 = [[ReviewListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 147*UIRate) andState:0];
    listView1.delegate = self;
    [_mScrollView addSubview:listView1];
    
    ReviewListView *listView2 = [[ReviewListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 147*UIRate) andState:1];
    listView2.delegate = self;
    [_mScrollView addSubview:listView2];
    
    ReviewListView *listView3 = [[ReviewListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 147*UIRate) andState:2];
    listView3.delegate = self;
    [_mScrollView addSubview:listView3];
}


- (UIButton *)creatButtonWithTitle:(NSString *)title
{
    UIButton *allButton = [[UIButton alloc] init];
    [allButton setTitle:title forState:UIControlStateNormal];
    [allButton setTitleColor:COLOR_Black forState:UIControlStateNormal];
    allButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [allButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return allButton;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat rate = offsetX/3.0;
    
    _indicatorView.frame = CGRectMake(rate, 144*UIRate, ScreenWidth/3.0, 3*UIRate);
}


#pragma mark - Action
//搜索
-(void)buttonAction{
    [self.view endEditing:YES];
    if (!self.textField.text.length){
        [LCProgressHUD showFailure:@"请输入商标名称"];
        return;
    }
    queryVC *vc = [[queryVC alloc]init];
    vc.nameString = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)selectButtonAction:(UIButton *)button{
    [self.view endEditing:YES];
    switch (button.tag) {
        case 10000:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _indicatorView.frame = CGRectMake(0, 144*UIRate, ScreenWidth/3.0, 3*UIRate);
                _mScrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
        case 10001:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _indicatorView.frame = CGRectMake(ScreenWidth/3.0, 144*UIRate, ScreenWidth/3.0, 3*UIRate);
                _mScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
            }];
        }
            break;
        case 10002:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _indicatorView.frame = CGRectMake(ScreenWidth/3.0*2, 144*UIRate, ScreenWidth/3.0, 3*UIRate);
                _mScrollView.contentOffset = CGPointMake(ScreenWidth*2, 0);
            }];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - ReviewListViewDelegate
- (void)clickRowWithModel:(ReviewListModel *)model
{
    ReviewResultDetailVC *vc = [[ReviewResultDetailVC alloc] init];
    vc.recheckId = model.recheckId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
