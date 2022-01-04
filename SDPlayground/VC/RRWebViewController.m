//
//  RRWebViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/27.
//

#import "RRWebViewController.h"

@interface RRWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.urlString = @"https://newonline.chime.me/";
//    self.urlString = @"https://chime.me/admin/home#/referral?app=1"
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlString stringByRemovingPercentEncoding]]]];
}




- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor yellowColor];
        _webView.frame = self.view.bounds;
        _webView.delegate = self;
    }
    return _webView;
}


@end
