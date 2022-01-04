//
//  RRNewWebViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/5/27.
//

#import "RRNewWebViewController.h"
#import <WebKit/WKWebView.h>

@interface RRNewWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation RRNewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.urlString = @"https://newonline.chime.me/";
    self.urlString = @"https://chime.me/admin/home#/referral?app=1";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlString stringByRemovingPercentEncoding]]]];
    
    NSString *html_confirm = @"<!DOCTYPE html><html><head><meta charset='utf-8'><title>菜鸟教程(runoob.com)</title></head><body><script>confirm('Hello confirm')</script></body></html>";
    
    NSString *html_alert = @"<!DOCTYPE html><html><head><meta charset='utf-8'><title>菜鸟教程(runoob.com)</title></head><body><script>alert('Hello alert')</script></body></html>";
    
    
    NSString *html_prompt = @"<!DOCTYPE html><html><head><meta charset='utf-8'><title>菜鸟教程(runoob.com)</title></head><body><script>prompt('Hello prompt')</script></body></html>";


//    [self.webView loadHTMLString:html_prompt baseURL:nil];
}


//下面这些方法是交互JavaScript的方法
//JavaScript调用alert方法后回调的方法 message中为alert提示的信息 必须要在其中调用completionHandler()
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                        completionHandler();
                                                    }];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
    
    NSLog(@"%@",message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                            completionHandler(YES);
                                                        }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                            completionHandler(NO);
                                                        }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"%@",prompt);
    completionHandler(@"你大爷的");
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
//                                                                             message:prompt
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:^(UIAlertAction *action) {
//                                                            completionHandler(@"没有输入框");
//                                                        }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
//                                                        style:UIAlertActionStyleCancel
//                                                      handler:^(UIAlertAction *action){
//                                                            completionHandler(@"没有输入框");
//                                                        }]];
//    [self presentViewController:alertController animated:YES completion:nil];
}

- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor yellowColor];
        _webView.frame = self.view.bounds;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

@end
