//
//  IamMasterDetailsVC.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterDetailsVC.h"
#import "masterDetailsCell_1.h"
#import "masterDetailsCell_2.h"
#import "masterDetailsCell_3.h"
#import "masterDetailsCell_4.h"
#import "masterDetailsCell_5.h"
#import "masterDetailsCell_6.h"
#import "masterDetailsCell_7.h"
#import "masterDetailsCell_8.h"
#import "masterDetailsCell_9.h"
#import "masterDetailsCell_10.h"
#import "IamMasterDetailsCell_1.h"
#import "IamMasterDetailsCell_2.h"
#import "IamMasterDetailsCell_3.h"
#import "CBConnect.h"
#import "TaskModel.h"
#import "ToolsHelper.h"
#import "EditpageVC.h"
#import "NewNameVC.h"
#import "EditpageCell.h"
#import "TaskTouGaoModel.h"
#import "TaskAskAnswerListModel.h"
#import "IamMasterHeard.h"
#import "IamMasterFoot.h"
#import "listDictiionaryItemsModel.h"
#import "UserHelper.h"
#import "reportVC.h"


@interface IamMasterDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *showStr;
@property (nonatomic,strong) NSMutableArray *dataArray1;
@property (nonatomic,assign) CGFloat totalHeight;
@property (nonatomic,strong) UILabel *textFd;
@property (nonatomic,strong) UILabel *explainFD;
@property (nonatomic,assign) int touGaoId;
@property (nonatomic,strong) TaskAskAnswerListModel *listModel;
@property (nonatomic,strong) TaskAskAnswerListModel *typeModel;
@property (nonatomic,strong) NSString *itemContent;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) UIButton *releaseBtn;


@end

@implementation IamMasterDetailsVC

-(NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestData];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务详情";
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    self.navigationItem.rightBarButtonItem = barItem;
    [self drawView];
    [self requestData];
    [self maxNumber];
}
-(void)drawView{
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    self.tableView.backgroundColor = COLOR_BackgroundColor;
    UIView *footView = [[[UIView alloc]init]initWithFrame:CGRectZero];
    self.releaseBtn = [[UIButton alloc]init];
    [_releaseBtn setTitle:@"起名" forState:UIControlStateNormal];
    [_releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    _releaseBtn.backgroundColor = COLOR_ButtonBackGround_Orange;
    [_releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    _releaseBtn.layer.cornerRadius = 8;
    _releaseBtn.clipsToBounds = YES;
    [footView addSubview:_releaseBtn];
     self.tableView.tableFooterView = footView;
  
    
    footView.sd_layout
    .leftSpaceToView(self.view,20*UIRate)
    .rightSpaceToView(self.view,20*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .heightIs(60*UIRate);
    
    
    _releaseBtn.sd_layout
    .leftSpaceToView(footView,20*UIRate)
    .rightSpaceToView(footView,20*UIRate)
    .topSpaceToView(footView,10*UIRate)
    .heightIs(40*UIRate);
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        [weakSelf requestData];
    }];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7 + self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section > 6){
        TaskTouGaoModel *model = self.dataArray[section - 7];
        NSArray *array = model.taskAskAnswerList;
        return array.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        masterDetailsCell_1  *cell = [masterDetailsCell_1 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        DLog(@"%@",model.taskTitle);
        cell.titleLabel.text = model.taskTitle;
        cell.complete.hidden = YES;
        
        if (model.namedCategory == 1) {
            cell.tagLabel.text = @"商标起名";
        }else{
            cell.tagLabel.text = @"公司起名";
        }
        cell.priceLable.text = [NSString stringWithFormat:@"￥%.2f",model.priceYuan];
        
        return cell;
        
    }

    if (indexPath.section == 1) {
        masterDetailsCell_2  *cell = [masterDetailsCell_2 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"任务编号：%@",model.taskCode];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.taskCode inText:cell.titleLabel.text withColor:COLOR_Gray];
            cell.timeLabel.text =  [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
            
        }
    
        return cell;
    }
    if (indexPath.section == 2) {
        masterDetailsCell_3  *cell = [masterDetailsCell_3 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"所属行业：%@",model.categoryName];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.categoryName inText:cell.titleLabel.text withColor:COLOR_Gray];
        }
        
        return cell;
    }
    if (indexPath.section == 3) {
        masterDetailsCell_4  *cell = [masterDetailsCell_4 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"理想字数：%@",model.wordsNum];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.wordsNum inText:cell.titleLabel.text withColor:COLOR_Gray];
            
        }
        return cell;
    }
    if (indexPath.section == 4) {
        masterDetailsCell_5  *cell = [masterDetailsCell_5 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            NSDate *date = [NSDate dateWithTimeIntervalInMilliSecondSince1970:model.birthday];
            NSString *dateStr = [NSDate dateStringWithTimeDate:date dateFormat:@"yyyy年MM月dd日"];
            dateStr = [NSString stringWithFormat:@"%@ %d点",dateStr,model.birthhour];
            cell.titleLabel.text = [NSString stringWithFormat:@"出生时间：%@",dateStr];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:dateStr inText:cell.titleLabel.text withColor:COLOR_Gray];
            
            
        }
        return cell;
    }
    if (indexPath.section == 5) {
        masterDetailsCell_6  *cell = [masterDetailsCell_6 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.contentLabel.text = model.requireDetail;
        }
        return cell;
    }
    if (indexPath.section == 6) {
        masterDetailsCell_7  *cell = [masterDetailsCell_7 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"发布者：%@",model.creatorName];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.creatorName inText:cell.titleLabel.text withColor:COLOR_Gray];
        }
        return cell;
    }
   
    
    if (indexPath.section >= 7) {
        IamMasterDetailsCell_1  *cell = [IamMasterDetailsCell_1 cellWithTableView:tableView];
        TaskTouGaoModel *model = self.dataArray[indexPath.section - 7];
        NSArray *array = model.taskAskAnswerList;
        TaskAskAnswerListModel *model1 = array[indexPath.row];
        self.listModel = array[indexPath.row];
        NSString *userName = [UserHelper getMemberName];
        if ([userName isEqualToString:model1.creatorName]) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@回复:",model1.creatorName];
        }else{
            cell.nameLabel.text = [NSString stringWithFormat:@"%@提问:",model1.creatorName];
        }
        cell.answerLabel.text = model1.content;
        return cell;
    }
  
        return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70*UIRate;
    }
    if (indexPath.section == 5) {
        TaskModel *model = self.dataArray1.firstObject;
     CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth-30*UIRate  font:SYSTEM_FONT_(14*UIRate) string:model.requireDetail] ;
        return 50*UIRate+height;
    }
    if (indexPath.section >= 7) {
       
        TaskTouGaoModel *model = self.dataArray[indexPath.section - 7];
        NSArray *array = model.taskAskAnswerList;
        TaskAskAnswerListModel *model1 = array[indexPath.row];
        CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth - 135*UIRate font:SYSTEM_FONT_(15*UIRate) string:model1.content?:@" "];
        
        return 20*UIRate + height;
    }
    
    return 50*UIRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return 0.01;
    }
    if (section == 1) {
        return 20;
    }
    if (section >= 7) {
        TaskTouGaoModel *model = self.dataArray[section - 7];
        NSArray *array = model.picPaths;
        long row = (array.count > 0) ? ((array.count - 1) / 4 + 1) : 0;
        CGFloat height = row * 65 * UIRate + 85*UIRate;
        
        return height+5*UIRate;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section >= 7) {
        
        TaskTouGaoModel *model = self.dataArray[section - 7];
        NSArray *array = model.taskAskAnswerList;
             if (model.isCanAsk) {
                 return 0.01;
                 
             }else{
                 return 50;
             }
    }
    
    return 0.01;
}
// section == 7 footView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section > 6) {
       
        TaskTouGaoModel *model = self.dataArray[section - 7];
        NSArray *array = model.taskAskAnswerList;
        static NSString *viewIdentfier = @"footView";
        IamMasterFoot *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        if (!sectionFootView) {
            sectionFootView = [[IamMasterFoot alloc]initWithReuseIdentifier:viewIdentfier];
        }
      
            if (!model.isCanAnswer) {
                sectionFootView.replyBtn.hidden = YES;
            }else{
                sectionFootView.replyBtn.hidden = NO;
            }

       
        

        sectionFootView.saveblock = ^(){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入回复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField *txtName = [alert textFieldAtIndex:0];
            txtName.placeholder = @"请输入回复";
            DLog(@"%ld",(long)section);
            
            TaskTouGaoModel *model = self.dataArray[section - 7];
            DLog(@"%d",model.touGaoId);
            self.touGaoId = model.touGaoId;
            [alert show];
        };
        return sectionFootView;
    }
    return  [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 6) {
        
        TaskTouGaoModel *model = self.dataArray[section - 7];
        static NSString *viewIdentfier = @"headView";
        IamMasterHeard *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        sectionHeadView.backgroundColor = [UIColor whiteColor];
        if(!sectionHeadView){
        
            sectionHeadView = [[IamMasterHeard alloc] initWithReuseIdentifier:viewIdentfier];
        }
        sectionHeadView.model = model;
    
        __weak __typeof(self)weakSelf = self;
        sectionHeadView.editorblock = ^(){
        //编辑跳转
            weakSelf.touGaoId = model.touGaoId;
            [weakSelf editorbtn:model];
        };
        sectionHeadView.delectblock = ^(){
           //  删除
            weakSelf.touGaoId = model.touGaoId;
            // 提示框
            [self alertview];
            
        };

        return sectionHeadView;
    }
    return [UIView new];
}

-(void)alertview{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //执行删除操作
        [self delect];
        
    }];
    [alertController addAction:done];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)delect{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(self.touGaoId) forKey:@"touGaoId"];
    [CBConnect getHomeRemove:params success:^(id responseObject) {
        //删除成功重新请求数据
        [self requestData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];


}
-(void)imArray:(NSMutableArray *)arr{
    
    long row = 0;
    if (arr.count == 0){
        row = 0;
    }else{
        row = (arr.count - 1) / 4 + 1;
    }
    _totalHeight = row * 75 * UIRate;

}

#pragma mark ====  editorbtn编辑跳转 =============
-(void)editorbtn:(TaskTouGaoModel *)model{
    
    //编辑投稿
    EditpageVC *vc = [[EditpageVC alloc]init];
    vc.TouGaoId = self.touGaoId;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ========  起名 ========
-(void)footViewAction{
    
    NewNameVC *vc = [[NewNameVC alloc]init];
    vc.taskId = self.taskId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertViewDelegate
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
         UITextField *replyText = [alertView textFieldAtIndex:0];
              
     if (replyText.text.length != 0) {
         NSMutableDictionary *params = [CBConnect getBaseRequestParams];
         [params setValue:@(2) forKey:@"type"];
         [params setValue:replyText.text forKey:@"content"];
         [params setValue:@(self.touGaoId) forKey:@"touGaoId"];
         
         [CBConnect getHomeAskAnswer:params success:^(id responseObject) {
             [self requestData];
         } successBackfailError:^(id responseObject) {
             
         } failure:^(NSURLSessionDataTask *operation, NSError *error) {
             
         }];
     }
}
#pragma mark - ============网络－任务广场任务详情===============
- (void)requestData {
    
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.taskId) forKey:@"taskId"];
    [CBConnect getHomeTaskViewTask:params success:^(id responseObject) {
        
        TaskModel *model = [TaskModel mj_objectWithKeyValues:responseObject];
        [self.dataArray removeAllObjects];
        [self.dataArray1 removeAllObjects];
        [self.dataArray addObjectsFromArray:model.taskTouGaoList];
        TaskModel *model1 = [[TaskModel alloc]init];
        model1.categoryId = model.categoryId;
        model1.creatorId = model.creatorId;
        model1.taskMode = model.taskMode;
        model1.birthday = model.birthday;
        model1.taskCode = model.taskCode;
        model1.birthhour = model.birthhour;
        model1.priceYuan = model.priceYuan;
        model1.taskTitle = model.taskTitle;
        model1.expireTime = model.expireTime;
        model1.touGaoNum = model.touGaoNum;
        model1.categoryName = model.categoryName;
        model1.requireDetail = model.requireDetail;
        model1.itemContents = model.itemContents;
        model1.creatorName = model.creatorName;
        model1.wordsNum = model.wordsNum;
        model1.createdTimestamp = model.createdTimestamp;
        model1.taskId = model.taskId;
        [self.dataArray1 addObject:model1];

        [self.tableView.mj_header endRefreshing];
        // 判断起名按钮的名字转化
        [self isQiMing:self.dataArray.count];
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
-(void)isQiMing:(NSInteger)count{
    if (count>0) {
         [_releaseBtn setTitle:@"继续起名" forState:UIControlStateNormal];
    }else{
         [_releaseBtn setTitle:@"起名" forState:UIControlStateNormal];
    }
    
}

#pragma mark - ============ 提问次数上限  ===============
-(void)maxNumber{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:@"dg_max_ask_num" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:parms success:^(id responseObject) {
        NSArray *array = [listDictiionaryItemsModel mj_objectArrayWithKeyValuesArray:responseObject];
        for (listDictiionaryItemsModel *model in array){
            self.itemContent = [NSString stringWithFormat:@"%@",model.itemContent];
        }
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//举报
- (void)reportAction{
    if (self.dataArray1.count) {
        TaskModel *model = self.dataArray1.firstObject;
        reportVC *vc = [[reportVC alloc]init];
        vc.TouGaoId = model.taskId;
        vc.brandName = model.taskTitle;
        vc.entityMode = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
