//
//  WemartMarketViewController.m
//  WemartDemo
//
//  Created by DongYifan on 5/22/15.
//  Copyright (c) 2015 Wemart. All rights reserved.
//

#import "WemartMarketViewController.h"
#import "Header.h"
#import "DigitInformation.h"
#import "ShareUtils.h"
#import "WemartProduct.h"
#import "UIImageView+WebCache.h"
#import "UIImage+AddFunction.h"
#import "XTAnimation.h"
#import "UIViewController+NavExtension.h"
#import "YouzanViewController.h"

@interface WemartMarketViewController ()
//{
//    BOOL isfirstTime ;
//}
//@property (nonatomic,copy) NSString      *strIndexPage ;

@property (nonatomic,strong) UIImageView *userImageView ;
@property (nonatomic,strong) UIImageView *refreshImageView ;
@property (nonatomic,strong) UIImageView *shareImageView ;
@property (nonatomic,strong) UIImageView *shuffleImageView ;

@end

@implementation WemartMarketViewController

//- (void)setStrIndexPage:(NSString *)strIndexPage
//{
//    if (isfirstTime && strIndexPage != nil)
//    {
//        isfirstTime = false ;
//        _strIndexPage = strIndexPage ;
//    }
//}

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

- (void)shareWithIndex:(NSNotification *)notification
{
    if (!self.view.window) return ;
    
    NSString * sharedData = [self getSharedData] ;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[sharedData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] ;
    WemartProduct *wemartProduct = [[WemartProduct alloc] initWithDic:dict] ;
    [wemartProduct getImageWillShareWithShareIndex:[notification.object intValue] ctrller:self] ;
}

#pragma mark --
#pragma mark - Life
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
                                      bShuffle:^{
                                        [self shuffle] ;
        }
         ] ;
    }
    else
    {
        self.navigationController.navigationBarHidden = YES ;
    }

    [super viewDidLoad];
    
//    isfirstTime = YES ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;

    if (self.navigationController.hidesBarsOnSwipe == NO && G_CHECK_SWITCH) {
        
        self.navigationController.hidesBarsOnSwipe = YES ;
        self.navigationController.navigationBarHidden = NO ;
    }
}

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
    UIWebView *webView = [self valueForKey:@"webView"] ;
    [webView reload] ;
}

- (void)shuffle
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHUFFLE_NOTIFICAITON object:WM_SHUFFLE_NOTIFICAITON] ;
}

#pragma mark --
#pragma mark - WebView Delegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString * sharedData = [self getSharedData];
//    NSLog(@"%@", sharedData);
//}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"webView failed :%@", error);
//}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSString *absoluteStr = [webView.request.URL absoluteString] ;
//    self.strIndexPage = absoluteStr ;
//    NSLog(@"self.strIndexPage : %@",self.strIndexPage) ;
//    NSLog(@"absoluteStr       : %@",absoluteStr) ;
//
//    if ([absoluteStr isEqualToString:self.strIndexPage] && G_CHECK_SWITCH) {
//        self.navigationController.hidesBarsOnSwipe = YES ;
//        self.navigationController.navigationBarHidden = NO ;
//    }
//    else {
//        self.navigationController.hidesBarsOnSwipe = NO ;
//        self.navigationController.navigationBarHidden = YES ;
//    }
//    
//    return YES ;
//}

@end
