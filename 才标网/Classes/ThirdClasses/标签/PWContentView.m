//
//  PWContentView.m
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 lihao. All rights reserved.
//

#import "PWContentView.h"

@implementation PWContentView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{

    
    if (self = [super initWithFrame:frame]) {
        
        
       
        for (int i = 0; i < array.count; i ++)
        {
            //        Area *are = cell_Array[i];
            
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            self.btn = [[UIButton alloc]init];
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 5;
            CGFloat BtnH = rect.size.height + 2.5;
            
            
            self.btn.layer.masksToBounds = YES;
            
            self.btn.layer.cornerRadius = BtnH/2;
            [self.btn.layer setBorderWidth:1];//设置边界的宽度
            self.btn.layer.borderWidth = 1;
//            self.btn.layer.borderColor = HEXCOLOR(0xff6600).CGColor;
//            [self.btn setTitleColor:HEXCOLOR(0xff6600) forState:UIControlStateNormal];

            self.btn.layer.borderColor = COLOR_LightGray.CGColor;
            [self.btn setTitleColor:COLOR_LightGray forState:UIControlStateNormal];
            if (i == 0)
            {
                self.btn.frame =CGRectMake(10, 10, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                
                    self.btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    self.btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
                }
                
            }
            self.btn.backgroundColor = [UIColor whiteColor];
            [self.btn setTitle:name forState:UIControlStateNormal];
            self.btn.titleLabel.font = [UIFont systemFontOfSize:12];
            self.btn.selected = NO;
            [self addSubview:self.btn];
            
            NSLog(@"btn.frame.origin.y  %f", self.btn.frame.origin.y);
            self.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20,CGRectGetMaxY(self.btn.frame)+10);
            recordBtn = self.btn;
            
            self.btn.tag = 100 + i;

            [self.btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }


    return self;

}

    
-(id)initWithFrame1:(CGRect)frame dataArr:(NSArray *)array{
    
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        for (int i = 0; i < array.count; i ++)
        {
            //        Area *are = cell_Array[i];
            
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            self.btn = [[UIButton alloc]init];
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 5;
            CGFloat BtnH = rect.size.height + 2.5;
            
            
            self.btn.layer.masksToBounds = YES;
            
            self.btn.layer.cornerRadius = BtnH/2;
            [self.btn.layer setBorderWidth:1];//设置边界的宽度
            self.btn.layer.borderWidth = 1;
                        self.btn.layer.borderColor = HEXCOLOR(0xff6600).CGColor;
                        [self.btn setTitleColor:HEXCOLOR(0xff6600) forState:UIControlStateNormal];
            
//            self.btn.layer.borderColor = COLOR_LightGray.CGColor;
//            [self.btn setTitleColor:COLOR_LightGray forState:UIControlStateNormal];
            if (i == 0)
            {
                self.btn.frame =CGRectMake(10, 10, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                    
                    self.btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    self.btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
                }
                
            }
            self.btn.backgroundColor = [UIColor whiteColor];
            [self.btn setTitle:name forState:UIControlStateNormal];
            self.btn.titleLabel.font = [UIFont systemFontOfSize:12];
            self.btn.selected = NO;
            [self addSubview:self.btn];
            
            NSLog(@"btn.frame.origin.y  %f", self.btn.frame.origin.y);
            self.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20,CGRectGetMaxY(self.btn.frame)+10);
            recordBtn = self.btn;
            
            self.btn.tag = 100 + i;
            
//            [self.btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    return self;
    
    
}
    

    
-(void) BtnClick:(UIButton *)sender{

    __weak typeof(self) weakSelf = self;

    if (sender.selected == YES) {
        sender.selected = NO;
        sender.layer.borderColor = COLOR_LightGray.CGColor;
        [sender setTitleColor:COLOR_LightGray forState:UIControlStateNormal];

        
    }else{
        sender.selected = YES;
        
        sender.layer.borderColor = COLOR_OrangeRed.CGColor;
        [sender setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    }
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag,sender.titleLabel.text);
    }

}

-(void) btnClickBlock:(BtnBlock)btnBlock{

    self.btnBlock = btnBlock;

}


@end
