//
//  WemartMarketViewController.m
//  WemartDemo
//
//  Created by DongYifan on 5/22/15.
//  Copyright (c) 2015 Wemart. All rights reserved.
//

#import "WemartMarketViewController.h"
#import "Header.h"

@implementation WemartMarketViewController

#pragma mark --
#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setHidesBarsOnSwipe:YES] ;

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClicked)] ;
    self.navigationItem.leftBarButtonItem = leftItem ;
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)] ;
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"replay"] style:UIBarButtonItemStylePlain target:self action:@selector(replay)] ;
    self.navigationItem.rightBarButtonItems = @[shareItem,refreshItem] ;
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

#pragma mark --
#pragma mark - WebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * sharedData = [self getSharedData];
    NSLog(@"%@", sharedData);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webView failed :%@", error);
}

//判断用户点击类型
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *tempUrl = request.URL ;
    NSString *absoluteStr = [tempUrl absoluteString] ;
    NSLog(@"you Click : %@", absoluteStr) ;

    return YES ;
}


@end
