//
//  ShoppingCtrller.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ShoppingCtrller.h"
#import "Header.h"

@implementation ShoppingCtrller

- (IBAction)leftButtonClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@1] ;
}

- (IBAction)rightButtonClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@2] ;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        NSString *userID = @"12" ;
        NSString *wmode = @"app" ;
        
//        NSString *sign = WEMART_APPSECRET ;
//        NSString *sign = [rsa signTheDataSHA1WithRSA:WEMART_APPSECRET] ;
//        NSLog(@"sign : %@",sign) ;
        
        NSString *appScheme = @"SubaoMart";
        self.appScheme = appScheme;
        
//        NSString *url = [NSString stringWithFormat:@"%@&wmode=%@&appId=%@&userId=%@&sign=%@",URL_SHOP_WEMART,wmode,WEMART_APPID,userID,sign] ;
        NSString *url = [NSString stringWithFormat:@"%@&wmode=%@&appId=%@&userId=%@",URL_SHOP_WEMART,wmode,WEMART_APPID,userID] ;
        
        NSLog(@"url : %@",url) ;
        self.initialURL = url ;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    [self.navigationController setHidesBarsOnSwipe:YES] ;
}

#pragma mark --
#pragma mark - web view delegate
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"webViewDidFinishLoad");
    
    NSLog(@"get share data : %@",[self getSharedData]) ;

}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"didFailLoadWithError:%@", error);
}

//判断用户点击类型
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *tempUrl = request.URL ;
    NSString *absoluteStr = [tempUrl absoluteString] ;
    NSLog(@"shouldStartLoadWithRequest : %@", absoluteStr) ;

    /*
     
     if ([absoluteStr isEqualToString:@"http://m.jgb.cn/"])
     {
     //去登录, app登录成功后, 登录h5
     if (G_TOKEN == nil || [G_TOKEN isEqualToString:@""])
     {
     [NavRegisterController goToLoginFirstWithCurrentController:self AppLoginFinished:YES] ;
     }
     
     return NO ;
     }
     
     switch (navigationType)
     {
     //点击连接
     case UIWebViewNavigationTypeLinkClicked:
     {
     NSLog(@"clicked");
     
     if (!tempUrl) return YES ;
     
     NSString *sepStr = @"?sku=" ;
     
     if ([[absoluteStr componentsSeparatedByString:sepStr] count] <= 1) {
     return YES ;
     }
     
     NSString *goodsCode = [[absoluteStr componentsSeparatedByString:sepStr] lastObject];
     
     [self goIntoGoodsDetail:goodsCode] ;
     
     return NO ;
     }
     break ;
     //提交表单
     case UIWebViewNavigationTypeFormSubmitted:
     {
     NSLog(@"submitted");
     }
     break ;
     default:
     break;
     }
     
     return YES;
     */
    return YES ;
}

@end
