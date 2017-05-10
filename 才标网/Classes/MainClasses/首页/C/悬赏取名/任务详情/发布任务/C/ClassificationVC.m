//
//  ClassificationVC.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationVC.h"
#import "ClassificationCell.h"
#import "CBConnect.h"
#import "ClassificationVC_2.h"
#import "ClassificationVC_3.h"
#import "NavigationView.h"
#import "ClassSearchResultVC.h"

@interface ClassificationVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray  *seardataArray;
@property (strong, nonatomic) UITextField *searchTextField;

@end

@implementation ClassificationVC
-(NSMutableArray *)seardataArray{
    
    if (!_seardataArray) {
        _seardataArray = [NSMutableArray array];
    }
    return _seardataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //不下沉
    if (self.isDealNav){
    self.navigationController.navigationBar.translucent = YES;
    }
    self.navigationItem.title = @"分类查询";
    [self drawView];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isDealNav){
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    self.searchTextField.text = @"";
}

-(void)drawView{
    //处理Nav
    __weak typeof (self) weakSelf = self;
    CGFloat offsetHeight = 0;
    if (self.isDealNav){
        NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"分类查询" block:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.view addSubview:nav];
        
        offsetHeight = 64;
    }
    
    [self initSearchViewWithOffY:offsetHeight];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,offsetHeight + 60*UIRate)
    .bottomSpaceToView(self.view,0);
}

//搜索框
- (void)initSearchViewWithOffY:(CGFloat)height{
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, 60*UIRate)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15*UIRate, 10*UIRate, ScreenWidth - 30*UIRate, 40*UIRate)];
    backView.backgroundColor = COLOR_BackgroundColor;
    [holdView addSubview:backView];
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"brand_s_search_19x19"];
    [holdView addSubview:searchImageView];
    
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.font = SYSTEM_FONT_(15*UIRate);
    _searchTextField.textColor = COLOR_darkGray;
    _searchTextField.placeholder = @"请输入您想要搜索的关键词";
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.delegate = self;
    [holdView addSubview:_searchTextField];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = COLOR_OrangeRed;
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:searchBtn];
    
    searchImageView.sd_layout
    .leftEqualToView(backView).offset(10*UIRate)
    .centerYEqualToView(backView)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    searchBtn.sd_layout
    .rightEqualToView(backView)
    .heightRatioToView(backView,1)
    .widthIs(80*UIRate)
    .centerYEqualToView(backView);
    
    _searchTextField.sd_layout
    .leftSpaceToView(searchImageView,10*UIRate)
    .rightSpaceToView(searchBtn,5*UIRate)
    .heightRatioToView(backView,1)
    .centerYEqualToView(backView);
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationCell *cell = [ClassificationCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    TradeMarkCategoryModel *model = self.dataArray[indexPath.row];
    ClassificationVC_2 *vc = [[ClassificationVC_2 alloc]init];
    vc.filter_parent_id = model.sid;
    vc.titleText = model.category_name;
    vc.category_title = model.category_title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchBtnAction];
    return YES;
}

#pragma mark - Action
//搜索
- (void)searchBtnAction{
    [self.view endEditing:YES];
    if (_searchTextField.text.length == 0){
        [LCProgressHUD showFailure:@"请输入要搜索的关键字"];
        return;
    }
    ClassSearchResultVC *vc = [[ClassSearchResultVC alloc] init];
    vc.searchText = [_searchTextField.text copy];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
