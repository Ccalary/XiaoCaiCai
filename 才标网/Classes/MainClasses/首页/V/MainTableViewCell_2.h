//
//  MainTableViewCell_2.h
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MainTableViewCell_2BtnType) {
    ///自助起名
    MainTableViewCell_2BtnTypeSelf       = 0,
    ///悬赏起名
    MainTableViewCell_2BtnTypeReward     = 1,
    ///大师起名
    MainTableViewCell_2BtnTypeMaster     = 2,
};

@protocol MainTableViewCell_2Delegate <NSObject>

- (void)cell_2ClickButtonWithTag:(MainTableViewCell_2BtnType)tag andStr:(NSString *)str;

@end

@interface MainTableViewCell_2 : UITableViewCell

@property (nonatomic, weak) id<MainTableViewCell_2Delegate> delegate;

+ (MainTableViewCell_2 *)cellWithTableView:(UITableView *)tableView;

@end
