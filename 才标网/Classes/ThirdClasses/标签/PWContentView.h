//
//  PWContentView.h
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 lihao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)(NSInteger index,NSString *title);

@interface PWContentView : UIView

@property (nonatomic,copy) BtnBlock btnBlock;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,copy)NSString *stact;
    
-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array;
-(id)initWithFrame1:(CGRect)frame dataArr:(NSArray *)array;

@end
