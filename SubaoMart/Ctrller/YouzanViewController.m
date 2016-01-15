//
//  YouzanViewController.m
//  SubaoMart
//
//  Created by TuTu on 16/1/9.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "YouzanViewController.h"
#import "UIViewController+NavExtension.h"
#import "DigitInformation.h"
#import "UIImage+AddFunction.h"
#import "XTAnimation.h"
#import "Header.h"
#import "YZSDK.h"
#import "ShareUtils.h"
#import "KeyChainHeader.h"
#import "CommonWebViewController.h"
#import "UIImageView+WebCache.h"
#import "YouZanProduct.h"
#import "CurrentUser.h"
#import "HudManager.h"
#import "SingletonSegement.h"


/*
 页面的链接： 主要的事情多说几遍！！！！
 记住不要用短连接，短链接类似：http://kdt.im/......, 使用长连接，不然会多一次跳转https://wap.koudaitong.com/v2/showcase/homepage?alias=xxxxxx
 记住不要用短连接，短链接类似：http://kdt.im/......, 使用长连接，不然会多一次跳转https://wap.koudaitong.com/v2/showcase/homepage?alias=xxxxxx
 方式: 直接打开浏览器，输入短链接，打开的就是长链接地址
 方式: 直接打开浏览器，输入短链接，打开的就是长链接地址

 存在的问题，会员信息页面一定要记得先登录，登录只能从商品页面进入哦 【关键点】 【关键点】 【关键点】
 会员页面没登录不会做登陆回调事件！！！！
 会员页面没登录不会做登陆回调事件！！！！
 【我的购物记录】和【我的返现】里面因为有赞账号和三方账号没有打通，所以暂时还不能进行红包等等查看，我们已经在开发中了，敬请期待！！
 【我的购物记录】和【我的返现】里面因为有赞账号和三方账号没有打通，所以暂时还不能进行红包等等查看，我们已经在开发中了，敬请期待！！
 */

//static NSString *homePageUrl = @"https://wap.koudaitong.com/v2/showcase/homepage?alias=v8a881k2" ;
static NSString *homePageUrl = @"https://wap.koudaitong.com/v2/allgoods/14053342" ;

@interface YouzanViewController () <UIWebViewDelegate>
{
    int m_shareIndex ;
}
@property (nonatomic,strong) UIImageView *userImageView ;
@property (nonatomic,strong) UIImageView *refreshImageView ;
@property (nonatomic,strong) UIImageView *shareImageView ;
@property (nonatomic,strong) UIImageView *shuffleImageView ;

@property (nonatomic,strong) UIWebView *homePageWebView ;

@end

@implementation YouzanViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(shareWithIndex:)
                                                     name:SHARE_R_NOTIFICATION
                                                   object:nil] ;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(shake)
                                                     name:HIDE_MENU_NOTIFICATION
                                                   object:nil] ;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SHARE_R_NOTIFICATION
                                                  object:nil] ;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:HIDE_MENU_NOTIFICATION
                                                  object:nil] ;
}

static CGFloat duration = 0.38 ;

- (void)shake
{
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:self.userImageView] ;
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:self.shareImageView] ;
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:self.refreshImageView] ;
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:self.shuffleImageView] ;
}

static const void* kTempShareIndex = &kTempShareIndex ;
- (void)shareWithIndex:(NSNotification *)notification
{
    if (!self.view.window) return ;

    m_shareIndex = [notification.object intValue] ;
    
    NSString *jsonString = [[YZSDK sharedInstance] jsBridgeWhenShareBtnClick] ;
    [self.homePageWebView stringByEvaluatingJavaScriptFromString:jsonString] ;
    
    // go webv delegate .
}

- (void)share:(int)shareIndex diction:(NSDictionary *)shareDic
{
    if (!shareDic || shareIndex == -1) return ;

    //1 parse sharediction
    YouZanProduct *youzanPdt = [[YouZanProduct alloc] initWithDic:shareDic] ;
    [youzanPdt getImageWillShareWithShareIndex:shareIndex ctrller:self] ;
}

#pragma mark --
static float btSide = 25.0 ;

- (UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        _userImageView.image = [[UIImage imageNamed:@"user"] imageWithColor:[UIColor whiteColor]] ;
        _userImageView.contentMode = UIViewContentModeScaleAspectFit ;
    }
    return _userImageView ;
}

- (UIImageView *)refreshImageView
{
    if (!_refreshImageView) {
        _refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        _refreshImageView.image = [[UIImage imageNamed:@"replay"] imageWithColor:[UIColor whiteColor]];
        _refreshImageView.contentMode = UIViewContentModeScaleAspectFit ;
    }
    return _refreshImageView ;
}

- (UIImageView *)shareImageView
{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        _shareImageView.image = [[UIImage imageNamed:@"share"] imageWithColor:[UIColor whiteColor]] ;
        _shareImageView.contentMode = UIViewContentModeScaleAspectFit ;
    }
    return _shareImageView ;
}

- (UIImageView *)shuffleImageView
{
    if (!_shuffleImageView) {
        _shuffleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        _shuffleImageView.image = [[UIImage imageNamed:@"shuffle"] imageWithColor:[UIColor whiteColor]] ;
        _shuffleImageView.contentMode = UIViewContentModeScaleAspectFit ;
    }
    return _shuffleImageView ;
}

- (UIWebView *)homePageWebView
{
    if (!_homePageWebView) {
        _homePageWebView = [[UIWebView alloc] initWithFrame:self.view.bounds] ;
        _homePageWebView.delegate = self;
        [self loadRequestFromString:homePageUrl];
        if (![_homePageWebView superview]) {
            [self.view addSubview:_homePageWebView] ;
        }
    }
    return _homePageWebView ;
}

#pragma mark --
- (void)loadRequestFromString:(NSString*)urlString
{
    if ([[CurrentUser shareInstance] isLogined])
    {
//        YZUserModel *userModel = [CurrentUser getYZUserModelFromCacheUser:[[CurrentUser shareInstance] getCurrentUser]] ;
//        //注意:只要调用接口，一定要记得appID和appSecret的值的设置
//        [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
//            NSLog(@"message : %@",message) ;
//            if(isError) {
//                NSLog(@"YZSDK失败") ;
        
                NSURL *url = [NSURL URLWithString:urlString];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                [self.homePageWebView loadRequest:urlRequest];                
//            } else {
//                NSLog(@"YZSDK成功") ;
//
//                NSURL *url = [NSURL URLWithString:urlString];
//                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//                [self.homePageWebView loadRequest:urlRequest];
//            }
//        }];
    }
    else
    {
//        未登录
        [HudManager showHud:STR_NOT_LOGIN_YET] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@1] ;
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.homePageWebView loadRequest:urlRequest];
    }
    
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.homePageWebView stringByEvaluatingJavaScriptFromString:[[YZSDK sharedInstance] jsBridgeWhenWebDidLoad]] ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 *  页面监听请看这里
 *
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL] ;
    NSLog(@"测试url的链接数据: %@ ",[url absoluteString]) ;
    if([[url absoluteString] isEqualToString:homePageUrl]) {//第一个页面加载
        
    }
    else if(![[url absoluteString] hasPrefix:@"http"]) {//非http
        
        NSString *jsBridageString = [[YZSDK sharedInstance] parseYOUZANScheme:url];
        
        if(jsBridageString) {
            
            if([jsBridageString isEqualToString:CHECK_LOGIN]) {//首页面不涉及到登录  具体实现看commonVC
                
            } else if([jsBridageString isEqualToString:SHARE_DATA]) {
                
                NSDictionary *shareDic = [[YZSDK sharedInstance] shareDataInfo:url];
                NSLog(@"shareDic : %@",shareDic) ;
                NSLog(@"m_shareIndex : %@",@(m_shareIndex)) ;
                [self share:m_shareIndex diction:shareDic] ;
                
            } else if([jsBridageString isEqualToString:WEB_READY]) {

                
            } else if([jsBridageString isEqualToString:WX_PAY]) { //首页面不涉及到微信支付  具体实现看commonVC
                
            }
        }
    } else if ([[url absoluteString] hasSuffix:@"common/prefetching"]) {//加载静态资源 暂时先屏蔽
        return YES;
    } else {
        CommonWebViewController *commonWebViewViewController = [[CommonWebViewController alloc] init] ;
        commonWebViewViewController.commonWebViewUrl = [url absoluteString];
        [self.navigationController pushViewController:commonWebViewViewController animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark --
- (void)viewDidLoad
{
    if (G_CHECK_SWITCH)
    {
        [self customNavigationBarWithUserImage:self.userImageView
                                    shareImage:self.shareImageView
                                  refreshImage:self.refreshImageView
                                  shuffleImage:self.shuffleImageView
                                  bLeftClicked:^{
                                        [self leftButtonClicked] ;
                                    }
                                 bRightClicked:^{
                                        [self rightButtonClicked] ;
                                    }
                                       bReplay:^{
                                        [self replay] ;
                                    }
                                      bShuffle:^(int index){
                                          [self shuffleWithIndex:index] ;
                                    }
         ] ;
    }
    else
    {
        self.navigationController.navigationBarHidden = YES ;
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

// setup
    m_shareIndex = -1 ;
    [self homePageWebView] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    if (self.navigationController.hidesBarsOnSwipe == NO) {
        self.navigationController.hidesBarsOnSwipe = YES ;
    }
    
    [self.segement setSelectedSegmentIndex:[SingletonSegement shareInstance].selectedIndex] ;
}

#pragma mark --

- (void)leftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@1] ;
}

- (void)rightButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SLIDER_NOTIFICATION object:@2] ;
}

- (void)replay
{
    [self.homePageWebView reload] ;
}

- (void)shuffleWithIndex:(int)index
{
//    NSLog(@"shuffleWithIndex %d",index) ;
    [SingletonSegement shareInstance].selectedIndex = index ;
    
    if (index == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHUFFLE_NOTIFICAITON object:YZ_SHUFFLE_NOTIFICAITON] ;
    }
    else if (index == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHUFFLE_NOTIFICAITON object:WM_SHUFFLE_NOTIFICAITON] ;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
