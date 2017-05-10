//
//  masterDetailsVC.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsVC.h"
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
#import "TaskModel.h"
#import "CBConnect.h"
#import "ToolsHelper.h"
#import "MasterHeard.h"
#import "MasterFoot.h"
#import "TaskTouGaoModel.h"
#import "TaskAskAnswerListModel.h"
#import "UserHelper.h"
#import "RegisterTrademarkVC.h"
#import "listDictiionaryItemsModel.h"
#import "reportVC.h"

@interface masterDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic,assign) int touGaoId;

@property (nonatomic,strong) TaskAskAnswerListModel *typeModel;

@property (nonatomic,strong) NSString *itemContent;
@property (nonatomic,strong) NSString *row1MoreHieght;
@end

@implementation masterDetailsVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}

-(NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    self.navigationItem.rightBarButtonItem = barItem;

    [self drawView];
    [self requestData];
    [self maxNumber];
}
-(void)drawView{
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

//    [self.view addSubview:self.tableView];
    self.view = self.tableView;
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [weakSelf requestData];
    }];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8 + self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section > 7){
        TaskTouGaoModel *model = self.dataArray[section - 8];
        NSArray *array = model.taskAskAnswerList;
        return array.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0){
        masterDetailsCell_1  *cell = [masterDetailsCell_1 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
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
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.taskCode inText:cell.titleLabel.text withColor:COLOR_LightGray];
            cell.timeLabel.text =  [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
            
        }

        return cell;
    }
    if (indexPath.section == 2) {
        masterDetailsCell_3  *cell = [masterDetailsCell_3 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"所属行业：%@",model.categoryName];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.categoryName inText:cell.titleLabel.text withColor:COLOR_LightGray];
        }

        return cell;
    }
    if (indexPath.section == 3) {
        masterDetailsCell_4  *cell = [masterDetailsCell_4 cellWithTableView:tableView];
        TaskModel *model = self.dataArray1.firstObject;
        if (self.dataArray1.count != 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"理想字数：%@",model.wordsNum];
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.wordsNum inText:cell.titleLabel.text withColor:COLOR_LightGray];
            
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
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:dateStr inText:cell.titleLabel.text withColor:COLOR_LightGray];
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
            cell.titleLabel.attributedText = [ToolsHelper changeSomeText:model.creatorName inText:cell.titleLabel.text withColor:COLOR_LightGray];
        }

        return cell;
    }
    if (indexPath.section == 7) {
        masterDetailsCell_8  *cell = [masterDetailsCell_8 cellWithTableView:tableView];
        TaskModel *model1 = self.dataArray1.firstObject;
      
        cell.model1 = model1;
        return cell;
    }
    
    if (indexPath.section >= 8) {
        TaskTouGaoModel *model = self.dataArray[indexPath.section - 8];
        NSArray *array = model.taskAskAnswerList;
        TaskAskAnswerListModel *model1 = array[indexPath.row];
        
        IamMasterDetailsCell_1  *cell = [IamMasterDetailsCell_1 cellWithTableView:tableView];
        
        cell.model = model1;
        return cell;
    }

    return [[UITableViewCell alloc] init];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 70*UIRate;
    }
    
    if (indexPath.section == 1) {
        return 50*UIRate;
    }
    if (indexPath.section == 2) {
        return 50*UIRate;
    }
    if (indexPath.section == 3) {
        return 50*UIRate;
    }
    if (indexPath.section == 4) {
        return 50*UIRate;
    }
    if (indexPath.section == 5) {
        TaskModel *model = self.dataArray1.firstObject;
        CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth-30*UIRate  font:SYSTEM_FONT_(14*UIRate) string:model.requireDetail] ;
        return 50*UIRate+height;
    }
    if (indexPath.section == 6) {
        return 50*UIRate;
    }
    if (indexPath.section == 7) {
        
        if ([self.row1MoreHieght isEqualToString:@"0"]){
            return 100*UIRate;
        }else {
            return 50*UIRate + self.row1MoreHieght.doubleValue;
        }
       
    }
    
    if (indexPath.section > 7) {
        
        TaskTouGaoModel *model = self.dataArray[indexPath.section - 8];
        NSArray *array = model.taskAskAnswerList;
        TaskAskAnswerListModel *model1 = array[indexPath.row];
        CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth - 135*UIRate font:SYSTEM_FONT_(15*UIRate) string:model1.content?:@" "];
        
        return 20*UIRate + height;
    }
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    if (section == 7) {
        return 20;
    }
    
    if (section > 7){
        TaskTouGaoModel *model = self.dataArray[section - 8];
        NSArray *array = model.picPaths;
        long row = (array.count > 0) ? ((array.count - 1) / 4 + 1) : 0;
        CGFloat height = row * 65 * UIRate + 75*UIRate;
        
        return height+5*UIRate;


    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section > 7){
        
        TaskTouGaoModel *model = self.dataArray[section - 8];
        if (model.isCanAsk) {
            return 60;
        }else{
            return 10;
        }
       
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 7) {
         TaskTouGaoModel *model = self.dataArray[section - 8];

        static NSString *viewIdentfier = @"headView";
        MasterHeard *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        sectionHeadView.backgroundColor = [UIColor whiteColor];
        if(!sectionHeadView){
            
            sectionHeadView = [[MasterHeard alloc] initWithReuseIdentifier:viewIdentfier];
        }
        sectionHeadView.model = model;
        sectionHeadView.titleLabel.text =[NSString stringWithFormat:@"名称:%@",model.brandName];
        sectionHeadView.titleLabel.attributedText = [ToolsHelper changeSomeText:model.brandName inText:sectionHeadView.titleLabel.text withColor:COLOR_LightGray];

        sectionHeadView.explainLabel.text =[NSString stringWithFormat:@"释义:%@",model.reason];
        sectionHeadView.explainLabel.attributedText = [ToolsHelper changeSomeText:model.reason inText:sectionHeadView.explainLabel.text withColor:COLOR_LightGray];
        sectionHeadView.regisblock = ^(){
          //注册商标
            RegisterTrademarkVC *vc = [[RegisterTrademarkVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return sectionHeadView;
 
    }
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = COLOR_BackgroundColor;
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section > 7) {
        static NSString *viewIdentfier = @"footView";
        MasterFoot *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        if (!sectionFootView) {
            sectionFootView = [[MasterFoot alloc]initWithReuseIdentifier:viewIdentfier];
        }
        TaskTouGaoModel *model = self.dataArray[section - 8];
        if (model.isCanAsk) {
            sectionFootView.registeredBtn.hidden = NO;
        }else{
            sectionFootView.registeredBtn.hidden = YES;
        }
        
        sectionFootView.saveblock = ^(){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入提问" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField *txtName = [alert textFieldAtIndex:0];
            txtName.placeholder = @"请输入提问";
            TaskTouGaoModel *model = self.dataArray[section - 8];
            self.touGaoId = model.touGaoId;
            [alert show];
   
        };
        return sectionFootView;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = COLOR_BackgroundColor;
    
    return view;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *replyText = [alertView textFieldAtIndex:0];
    if (replyText.text.length != 0) {
        NSMutableDictionary *params = [CBConnect getBaseRequestParams];
        [params setValue:@(1) forKey:@"type"];
        [params setValue:replyText.text forKey:@"content"];
        [params setValue:@(self.touGaoId) forKey:@"touGaoId"];
        
        DLog(@"%@",params);
        
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(self.taskId) forKey:@"taskId"];
    [CBConnect getHomeTaskViewTask:params success:^(id responseObject) {
        
        TaskModel *model = [TaskModel mj_objectWithKeyValues:responseObject];
        [self.dataArray1 removeAllObjects];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:model.taskTouGaoList];
        //判断行高
        [self jus:model.teDian];
        [self.dataArray1 addObject:model];
         [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];

    } successBackfailError:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
}
-(void)jus:(NSString *)str{
    
    NSArray *array = [str componentsSeparatedByString:@"#"];
    if (array.count > 0){
        self.row1MoreHieght = [ToolsHelper tagHeightWithArray:array andWidht:ScreenWidth - 100*UIRate andCornerScale:0.2];
    }else {
        self.row1MoreHieght = @"0";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
