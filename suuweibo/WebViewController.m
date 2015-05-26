//
//  WebViewController.m
//  suuweibo
//
//  Created by suusatoshigii on 15-5-27.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webaView loadRequest:request];
    
    self.title = @"loading...";
    //网络状态栏旋转
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark -- webView Deleagate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //网络状态栏旋转
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //webview里有个方法可以执行javascript代码，利用这个代码修改title
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self!=nil) {
        _urlString = [url copy];
    }
    return self;
}

- (IBAction)goBack:(id)sender {
    if ([_webaView canGoBack]) {
        [_webaView goBack];
    }
}

- (IBAction)reload:(id)sender {
    [_webaView reload];
}

- (IBAction)goForward:(id)sender {
    if ([_webaView canGoForward]) {
        [_webaView goForward];
    }
}
@end
