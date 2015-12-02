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
#import "XTAnimation.h"
#import "UIImage+AddFunction.h"

@interface WemartMarketViewController ()
{
    UIImageView *m_userImage ;
    UIImageView *m_refreshImage ;
    UIImageView *m_shareImage ;
}
@end

@implementation WemartMarketViewController

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

static CGFloat duration = 0.68 ;

- (void)shake
{
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:m_userImage] ;
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:m_shareImage] ;
    [XTAnimation shakeRandomDirectionWithDuration:duration AndWithView:m_refreshImage] ;
}

- (void)shareWithIndex:(NSNotification *)notification
{
    NSString * sharedData = [self getSharedData];
    NSLog(@"%@", sharedData);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[sharedData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] ;
    WemartProduct *wemartProduct = [[WemartProduct alloc] initWithDic:dict] ;
    
    UIImage *resultImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:wemartProduct.thumbData] ;
    if (!resultImage)
    {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:wemartProduct.thumbData]
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                
                                                                [self shareFuncWithImage:image
                                                                               wemartPdt:wemartProduct
                                                                                   index:[notification.object intValue]] ;
                                                                
                                                            }] ;
    }
    else
    {
        [self shareFuncWithImage:resultImage
                       wemartPdt:wemartProduct
                           index:[notification.object intValue]] ;
    }
}

- (void)shareFuncWithImage:(UIImage *)image
                 wemartPdt:(WemartProduct *)wemartProduct
                     index:(int)index
{
    switch (index)
    {
        case 0:
        {
            [ShareUtils weiboShareFuncWithContent:STR_I_WANT_BUY
                                              url:wemartProduct.shareUrl
                                            image:image
                                          ctrller:self] ;
        }
            break;
        case 1:
        {
            [ShareUtils weixinShareFuncTitle:STR_I_WANT_BUY
                                     content:[wemartProduct.title stringByAppendingString:wemartProduct.content]
                                         url:wemartProduct.shareUrl
                                       image:image
                                     ctrller:self] ;
        }
            break;
        case 2:
        {
            [ShareUtils wxFriendShareFuncTitle:STR_I_WANT_BUY
                                       Content:[wemartProduct.title stringByAppendingString:wemartProduct.content]
                                           url:wemartProduct.shareUrl
                                         image:image
                                       ctrller:self] ;
        }
            break;
        default:
            break;
    }
}


#pragma mark --
#pragma mark - Life

static float btSide = 25.0 ;

- (void)viewDidLoad
{
    if (G_CHECK_SWITCH) {
        [self.navigationController setHidesBarsOnSwipe:YES] ;
        
        m_userImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        m_userImage.image = [[UIImage imageNamed:@"user"] imageWithColor:[UIColor whiteColor]] ;
        m_userImage.contentMode = UIViewContentModeScaleAspectFit ;
        UIButton *btUser = [[UIButton alloc] init] ;
        btUser.bounds = m_userImage.bounds ;
        [btUser addSubview:m_userImage] ;
        [btUser addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btUser] ;
        self.navigationItem.leftBarButtonItem = leftItem ;

        m_shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        m_shareImage.image = [[UIImage imageNamed:@"share"] imageWithColor:[UIColor whiteColor]] ;
        m_shareImage.contentMode = UIViewContentModeScaleAspectFit ;
        UIButton *btShare = [[UIButton alloc] init] ;
        btShare.bounds = m_shareImage.bounds ;
        [btShare addSubview:m_shareImage] ;
        [btShare addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:btShare] ;
        
        m_refreshImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btSide, btSide)] ;
        m_refreshImage.image = [[UIImage imageNamed:@"replay"] imageWithColor:[UIColor whiteColor]];
        m_refreshImage.contentMode = UIViewContentModeScaleAspectFit ;
        UIButton *btRefresh = [[UIButton alloc] init] ;
        btRefresh.bounds = m_refreshImage.bounds ;
        [btRefresh addSubview:m_refreshImage] ;
        [btRefresh addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside] ;
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:btRefresh] ;
        
        self.navigationItem.rightBarButtonItems = @[shareItem,refreshItem] ;

//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)] ;
//        self.navigationItem.leftBarButtonItem = leftItem ;
//        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)] ;
//        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"replay"] style:UIBarButtonItemStylePlain target:self action:@selector(replay)] ;
//        self.navigationItem.rightBarButtonItems = @[shareItem,refreshItem] ;
    }
    else {
        self.navigationController.navigationBarHidden = YES ;
    }

    
    [super viewDidLoad];
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

//#pragma mark --
//#pragma mark - WebView Delegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString * sharedData = [self getSharedData];
//    NSLog(@"%@", sharedData);
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"webView failed :%@", error);
//}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSURL *tempUrl = request.URL ;
//    NSString *absoluteStr = [tempUrl absoluteString] ;
////    NSLog(@"you Click : %@", absoluteStr) ;
//
//    return YES ;
//}

@end
