//
//  ServiceVC.m
//  才标网
//
//  Created by baichun on 17/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ServiceVC.h"
#import "NavigationView.h"
#import "UserHelper.h"

@interface ServiceVC ()<UIWebViewDelegate>
{
    
    BOOL theBool;
    //IBOutlet means you can place the progressView in Interface Builder and connect it to your code
    UIProgressView* myProgressView;
    NSTimer *myTimer;
}
@property (nonatomic, strong) UIWebView *mWebView;

@end

@implementation ServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"客服";
    
    //不下沉
    if (self.isDealNav){
        self.navigationController.navigationBar.translucent = YES;
    }
    __weak typeof (self) weakSelf = self;
    CGFloat offsetHeight = 0;
    if (self.isDealNav){
        NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"客服" block:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.view addSubview:nav];
        
        offsetHeight = 64;
    }

    _mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, offsetHeight, ScreenWidth, ScreenHeight)];
    _mWebView.delegate = self;
    _mWebView.scalesPageToFit = YES;
    _mWebView.backgroundColor = [UIColor clearColor];
    _mWebView.opaque = NO;
    _mWebView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:_mWebView];

    if (!self.uilString) {
        NSURL* url = [NSURL URLWithString:[UserHelper getServiceUrl]];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_mWebView loadRequest:request];//加载
    }else{
        NSURL* url = [NSURL URLWithString:self.uilString];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_mWebView loadRequest:request];//加载
    }

    // 仿微信进度条
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    myProgressView = [[UIProgressView alloc] initWithFrame:barFrame];
    myProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    myProgressView.progressTintColor = [UIColor colorWithRed:43.0/255.0 green:186.0/255.0  blue:0.0/255.0  alpha:1.0];
    [self.navigationController.navigationBar addSubview:myProgressView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isDealNav){
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

#pragma mark - UIWebViewDelegate
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    myProgressView.progress = 0;
    theBool = false;
    //0.01667 is roughly 1/60, so it will update at 60 FPS
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}

#pragma mark 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
     theBool = true;
}

#pragma mark 网页加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error {
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), error.localizedDescription);
}

#pragma mark 网页监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", request.URL.absoluteString.stringByRemovingPercentEncoding);
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 移除 progress view
    // because UINavigationBar is shared with other ViewControllers
    [myProgressView removeFromSuperview];
}

-(void)timerCallback {
    if (theBool) {
        if (myProgressView.progress >= 1) {
            myProgressView.hidden = true;
            [myTimer invalidate];
        }
        else {
            myProgressView.progress += 0.1;
        }
    }
    else {
        myProgressView.progress += 0.05;
        if (myProgressView.progress >= 0.95) {
            myProgressView.progress = 0.95;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
