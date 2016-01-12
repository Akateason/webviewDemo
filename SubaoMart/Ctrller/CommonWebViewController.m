//
//  CommonWebViewController.m
//  YouzaniOSDemo
//
//  Created by youzan on 15/11/6.
//  Copyright (c) 2015年 youzan. All rights reserved.
//

#import "CommonWebViewController.h"
#import "YZSDK.h"
#import "KeyChainHeader.h"
#import "Header.h"
#import "YouZanProduct.h"
#import "UIImage+AddFunction.h"

@interface CommonWebViewController ()<UIWebViewDelegate>
{
    int m_shareIndex ;
}
@property (strong, nonatomic) UIWebView *commonWebView ;
@property (nonatomic,strong) UIImageView *shareImageView ;

@end

@implementation CommonWebViewController


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(shareWithIndex:)
                                                     name:SHARE_R_NOTIFICATION
                                                   object:nil] ;
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SHARE_R_NOTIFICATION
                                                  object:nil] ;
}

static const void* kTempShareIndex = &kTempShareIndex ;
- (void)shareWithIndex:(NSNotification *)notification
{
    if (!self.view.window) return ;
    
    m_shareIndex = [notification.object intValue] ;
    
    NSString *jsonString = [[YZSDK sharedInstance] jsBridgeWhenShareBtnClick] ;
    [self.commonWebView stringByEvaluatingJavaScriptFromString:jsonString] ;
    
    // go webv delegate .
}

- (void)share:(int)shareIndex diction:(NSDictionary *)shareDic
{
    if (!shareDic || shareIndex == -1) return ;
    
    //1 parse sharediction
    YouZanProduct *youzanPdt = [[YouZanProduct alloc] initWithDic:shareDic] ;
    [youzanPdt getImageWillShareWithShareIndex:shareIndex ctrller:self] ;
}

- (UIWebView *)commonWebView
{
    if (!_commonWebView) {
        _commonWebView = [[UIWebView alloc] initWithFrame:self.view.bounds] ;
        if (![_commonWebView superview]) {
            [self.view addSubview:_commonWebView] ;
        }
    }
    return _commonWebView ;
}

static float btSide = 25.0 ;
- (UIImageView *)shareImageView
{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        _shareImageView.image = [[UIImage imageNamed:@"share"] imageWithColor:[UIColor whiteColor]] ;
        _shareImageView.contentMode = UIViewContentModeScaleAspectFit ;
    }
    return _shareImageView ;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    // Do any additional setup after loading the view.
    [self navigationItemConfigure] ;
    
    self.commonWebView.delegate = self ;
    [self loadRequestFromString:_commonWebViewUrl] ;
}

- (void)navigationItemConfigure
{
    UIButton *btShare = [[UIButton alloc] init] ;
    btShare.bounds = self.shareImageView.bounds ;
    [btShare addSubview:self.shareImageView] ;
    [btShare addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:btShare] ;
    self.navigationItem.rightBarButtonItem = shareItem ;
}

- (void)rightButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@2] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    if (self.navigationController.hidesBarsOnSwipe == YES) {
        self.navigationController.hidesBarsOnSwipe = NO ;
    }
    
    if (self.navigationController.navigationBarHidden == YES) {
        self.navigationController.navigationBarHidden = NO ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequestFromString:(NSString*)urlString {
    
//    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
//    if(!cacheModel.isValid) {
//        
//        YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
//        [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
//            if(isError) {
//                cacheModel.isValid = NO;
//            } else {
//                cacheModel.isValid = YES;
//                NSURL *url = [NSURL URLWithString:urlString];
//                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//                [self.commonWebView loadRequest:urlRequest];
//            }
//        }];
//    } else {
//        cacheModel.isValid = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.commonWebView loadRequest:urlRequest];
//    }
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
     self.navigationItem.title = @"载入中...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationItem.title = [self.commonWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.commonWebView stringByEvaluatingJavaScriptFromString:[[YZSDK sharedInstance] jsBridgeWhenWebDidLoad]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    
   if(![[url absoluteString] hasPrefix:@"http"]){//非http
        
        NSString *jsBridageString = [[YZSDK sharedInstance] parseYOUZANScheme:url];
        
//        if(jsBridageString) {
//
//            CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
//            if([jsBridageString isEqualToString:CHECK_LOGIN] && !cacheModel.isValid) {
//
//                if(cacheModel.isLogined) {//【如果是您是先登录，在打开我们商城，走这种方式】
//                    YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
//                    NSString *string = [[YZSDK sharedInstance] webUserInfoLogin:userModel];
//                    [self.commonWebView stringByEvaluatingJavaScriptFromString:string];
//                    return YES;
//                }
//                //【如果您需要使用自己原生的登录，看这里的代码】
//                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                UINavigationController *navigation = [board instantiateViewControllerWithIdentifier:@"loginnav"];
//                LoginViewController *loginVC = [navigation.viewControllers objectAtIndex:0];
//                loginVC.loginBlock = ^(CacheUserInfo *cacheModel) {
//                    NSString *string = [[YZSDK sharedInstance] webUserInfoLogin:[CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel]];
//                    [self.commonWebView stringByEvaluatingJavaScriptFromString:string];
//                };
//                [self presentViewController:navigation animated:YES completion:^{
//                    
//                }];
//                return NO;
//            }
//        else
       
            if([jsBridageString isEqualToString:SHARE_DATA]) {//【分享请看这里】
                
                NSDictionary *shareDic = [[YZSDK sharedInstance] shareDataInfo:url] ;
                NSLog(@"shareDic : %@",shareDic) ;
                NSLog(@"m_shareIndex : %@",@(m_shareIndex)) ;
                [self share:m_shareIndex diction:shareDic] ;
                
            } else if([jsBridageString isEqualToString:WEB_READY]) {
                
                
            } else if ([[url absoluteString] hasSuffix:@"common/prefetching"]) {//加载静态资源 暂时先屏蔽
                return YES;
            }  else if([jsBridageString isEqualToString:WX_PAY]) { //【微信支付暂时用的有赞wap微信支付，我们给您的链接已经包含了微信支付所有信息，直接可以唤起您手机上的微信，进行支付，分享之后因为不是走微信注册的模式，所以无法直接返回您的App，详细可以看文档说明】
                
                //如果是微信自有支付或者app支付，现在基本没有商户在使用app支付了，因此这里默认是微信自有支付
                [YZSDK selfWXPayURL:url callback:^(NSDictionary *response, NSError *error) {
                    //返回的是一个包含微信支付的字典，取出微信支付相对应的参数
                    /*
                    PayReq* req  = [[PayReq alloc] init];
                    req.openID   = response[@"response"][@"appid"];
                    req.partnerId  = response[@"response"][@"partnerid"];
                    req.prepayId  = response[@"response"][@"prepayid"];
                    req.nonceStr  = response[@"response"][@"noncestr"];
                    req.timeStamp   = (unsigned int)[response[@"response"][@"timestamp"] longValue];
                    req.package  = response[@"response"][@"package"];
                    req.sign   = response[@"response"][@"sign"];
                    [WXApi sendReq:req]; */
                }];
            }
//        }
   } else {
//       _shareButton.hidden = YES;//进入新的链接后，记得隐藏分享按钮，等到下个页面完全打开(获取webready后显示)
   }
    return YES;
}

- (void) sharePage {//【分享是被动的，所以要给出点击事件进行触发】
    NSString *jsonString = [[YZSDK sharedInstance] jsBridgeWhenShareBtnClick];
    [self.commonWebView stringByEvaluatingJavaScriptFromString:jsonString];
}

@end
