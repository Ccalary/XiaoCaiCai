//
//  XuanShangHeardview.m
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "XuanShangHeardview.h"
#import "SUPopupMenu.h"
#import "SMenuButton.h"
#import "HeardViewCell.h"
@interface XuanShangHeardview ()<UITableViewDataSource, UITableViewDelegate>
{
    
    UIColor *_menuColor;
    NSInteger _numOfMenu;
    //当前选择的btn
    NSInteger _selectBtnIndex;
    //selecttitle的index
    NSInteger _currentTitleIndex;
    //select = yes的button
    NSInteger _currentIndex;
    UIView *_backgroundView;
    BOOL _show;
    
    
}
/**
 *  存放button
 */
@property (nonatomic, strong) NSMutableArray *titleBtnArray;
/**
 *  存放title
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XuanShangHeardview
- (NSMutableArray *)titleBtnArray{
    if(!_titleBtnArray){
        _titleBtnArray = [NSMutableArray new];
    }
    return _titleBtnArray;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArray withSelectColor:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _titleArray = [NSArray arrayWithArray:titleArray];
        _menuColor = [UIColor blackColor];
        _numOfMenu = titleArray.count;
        CGFloat btnW = SScreen_Width / _numOfMenu * 1.0;
        for (int i = 0; i < _numOfMenu; i++) {
            SMenuButton *btn = [[SMenuButton alloc]initWithFrame:CGRectMake(i * btnW, 0, btnW, self.frame.size.height)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:color forState:UIControlStateSelected];
            if ([[_titleArray objectAtIndex:i] count] > 1) {
                [btn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateSelected];
            }
            
            btn.titleLabel.font = MFont(15*UIRate);
            [btn setTitleColor:_menuColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[[titleArray objectAtIndex:i] objectAtIndex:0] forState:UIControlStateNormal];
            if (i == 0) {
                btn.selected = YES;
            }
            [self addSubview:btn];
            [self.titleBtnArray addObject:btn];
        }
        
        _currentIndex = 0;
        _currentTitleIndex = 0;
        _show = NO;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.origin.y, SScreen_Width, 0) style:UITableViewStylePlain];
        _tableView.tintColor = color;
        _tableView.rowHeight = 36;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_backgroundView addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)selectMenu:(SMenuButton *)sender{
    NSInteger selectIndex = [self.titleBtnArray indexOfObject:sender];
    if (_show) {
        if (selectIndex != _currentIndex ) {
            if (_selectBtnIndex == selectIndex) {
                [self dismissAnimationWithTableViewWithBtn:sender];
                return;
            }else{
                [self dismissAnimationWithTableViewWithBtn:_titleBtnArray[_currentIndex]];
            }
        }else{
            if (_selectBtnIndex != selectIndex) {
                [self dismissAnimationWithTableViewWithBtn:_titleBtnArray[_selectBtnIndex]];
            }else{
                [self dismissAnimationWithTableViewWithBtn:sender];
                return;
            }
        }
    }
    _selectBtnIndex = selectIndex;
    NSArray *array = _titleArray[_selectBtnIndex];
    
    if (array.count <= 1) {
        SMenuButton *btn = [self.titleBtnArray objectAtIndex:_currentIndex];
        btn.selected = NO;
        sender.selected = YES;
        _currentIndex = _selectBtnIndex;
        _currentTitleIndex = 0;
        _show = NO;
        [self.menuViewDelegate pullDownMenuView:self didSelectedIndex:[NSIndexPath indexPathForRow:_currentIndex inSection:_currentTitleIndex]];
    }else{
        //弹出tableView
        _show = YES;
        [self animationWithTableViewWithBtn:sender];
    }
    
}
//弹出tableview动画
- (void)animationWithTableViewWithBtn:(SMenuButton *)sender{
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), SScreen_Width, 0);
    _backgroundView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), SScreen_Width, SScreen_Height - CGRectGetMaxY(_tableView.frame));
    [_tableView reloadData];
    [self.superview addSubview:_backgroundView];
    [self.superview addSubview:_tableView];
    CGFloat tableViewH = [_tableView numberOfRowsInSection:0] * _tableView.rowHeight;
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewH);
        sender.imageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
    }];
}
//收回tableView动画
- (void)dismissAnimationWithTableViewWithBtn:(SMenuButton *)sender{
    //    [UIView animateWithDuration:0.2 animations:^{
    _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
    sender.imageView.layer.transform = CATransform3DIdentity;
    //    } completion:^(BOOL finished) {
    [_tableView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    _show = NO;
    //    }];
}
//收回动画
- (void)tapClick{
    [self dismissAnimationWithTableViewWithBtn:[self.titleBtnArray objectAtIndex:_selectBtnIndex]];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _titleArray[_selectBtnIndex];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = _titleArray[_selectBtnIndex];
    
    HeardViewCell *cell = [HeardViewCell cellWithTableView:tableView];
    [cell.titleLabel setTextColor:[UIColor grayColor]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.titleLabel.text = array[indexPath.row];
    
    cell.titleLabel.sd_resetLayout
    .leftSpaceToView(cell.contentView,0)
    .rightSpaceToView(cell.contentView,0)
    .topSpaceToView(cell.contentView,0)
    .bottomSpaceToView(cell.contentView,0);
    
    if ([cell.titleLabel.text isEqualToString:[[_titleArray objectAtIndex:_currentIndex] objectAtIndex:_currentTitleIndex]]) {
        [cell.titleLabel setTextColor:tableView.tintColor];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        cell.titleLabel.sd_resetLayout
        .leftSpaceToView(cell.contentView,0)
        .rightSpaceToView(cell.contentView,-40)
        .topSpaceToView(cell.contentView,0)
        .bottomSpaceToView(cell.contentView,0);
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SMenuButton *btn1 = [self.titleBtnArray objectAtIndex:_selectBtnIndex];
    SMenuButton *btn2 = [self.titleBtnArray objectAtIndex:_currentIndex];
    if (_selectBtnIndex != _currentIndex) {
        btn1.selected = YES;
        btn2.selected = NO;
    }
    _currentIndex = _selectBtnIndex;
    _currentTitleIndex = indexPath.row;
    [btn1 setTitle:[[_titleArray objectAtIndex:_currentIndex] objectAtIndex:_currentTitleIndex] forState:UIControlStateNormal];
    [self.menuViewDelegate pullDownMenuView:self didSelectedIndex:[NSIndexPath indexPathForRow:_currentIndex inSection:_currentTitleIndex]];
    [self dismissAnimationWithTableViewWithBtn:btn1];
}

@end
