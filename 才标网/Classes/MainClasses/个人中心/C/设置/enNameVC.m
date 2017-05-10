//
//  enNameVC.m
//  才标网
//
//  Created by baichun on 17/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "enNameVC.h"
#import "CBConnect.h"
@interface enNameVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *mWebView;

@end

@implementation enNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleName;
    _mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _mWebView.delegate = self;
    _mWebView.scalesPageToFit = YES;
    _mWebView.backgroundColor = [UIColor clearColor];
    _mWebView.opaque = NO;
    _mWebView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mWebView];
    [self requesData];
}
#pragma mark - UIWebViewDelegate
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
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
#pragma mark ===============网络请求====================
-(void)requesData{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:_enName forKey:@"enName"];
    [CBConnect HelpGetEnName:parms success:^(id responseObject) {
        NSString *urlStr = [NSString stringWithFormat:@"%@",responseObject[@"content"]];
        [_mWebView loadHTMLString:urlStr baseURL:nil];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
