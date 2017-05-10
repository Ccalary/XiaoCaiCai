//
//  GuideVC.m
//  才标网
//
//  Created by baichun on 17/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "GuideVC.h"

#define IMAGECOUNT 3
@interface GuideVC ()<UIScrollViewDelegate>

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self drawView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)drawView{
    
    //创建ScrollView
    UIScrollView *guideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight2)];
    //设置边缘不弹跳
    guideView.bounces = NO;
    //整页滚动
    guideView.pagingEnabled = YES;
    guideView.showsHorizontalScrollIndicator = NO;
    
    //加入多个子视图(ImageView)
    for(int i=0; i<IMAGECOUNT; i++){
        NSString *imgName = [NSString stringWithFormat:@"引导页%d",i+1];
        UIImage *image = [UIImage imageNamed:imgName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        CGRect frame = CGRectZero;
        frame.origin.x = i * guideView.frame.size.width;
        frame.size = guideView.frame.size;
        imageView.frame = frame;
        [guideView addSubview:imageView];
        
        if(i==IMAGECOUNT-1){
            //开启图片的用户点击功能
            imageView.userInteractionEnabled = YES;
            //加个按钮
            UIButton *button = [[UIButton alloc]init];
            
            button.frame = CGRectMake((imageView.frame.size.width-150)/2, imageView.frame.size.height*0.9, 170*UIRate, 45*UIRate);
            [imageView addSubview:button];
            [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    guideView.contentSize = CGSizeMake(IMAGECOUNT * ScreenWidth, ScreenHeight2);
    
    [self.view addSubview:guideView];

    guideView.delegate = self;

    
}
- (void)enter
{
    if (self.delegate){
        [self.delegate enterTheApp];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
