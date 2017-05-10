//
//  IamMasterHeard.h
//  才标网
//
//  Created by baichun on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTouGaoModel.h"

typedef void(^editorBlock)();
typedef void(^deleteBlock)();

@interface IamMasterHeard : UITableViewHeaderFooterView

@property (nonatomic,assign) CGFloat totalHeight;
@property (nonatomic,strong) UICollectionView *mCollectionView;

@property (nonatomic,strong) UIButton *editorBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

@property (nonatomic,copy) editorBlock editorblock;
@property (nonatomic,copy) deleteBlock delectblock;

@property (nonatomic,strong) TaskTouGaoModel *model;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
