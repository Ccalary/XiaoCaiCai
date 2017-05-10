//
//  MoveButton.h
//  JingJinSuo
//
//  Created by 曹后红 on 16/6/6.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveButton : UIButton
{
    CGPoint beginPoint;
}
@property (nonatomic) BOOL dragEnable;
@end
