//
//  NavCtrller.m
//  SubaoMart
//
//  Created by TuTu on 15/11/30.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "NavCtrller.h"
#import "Header.h"
#import "WemartMarketViewController.h"

@interface NavCtrller ()

@end

@implementation NavCtrller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *userID = @"1325" ;
    //        NSString *sign = WEMART_APPSECRET ;
    //        NSString *sign = [rsa signTheDataSHA1WithRSA:WEMART_APPSECRET] ;
    //        NSLog(@"sign : %@",sign) ;
    NSString *appScheme = @"SubaoMart";
    //        NSString *url = [NSString stringWithFormat:@"%@&wmode=%@&appId=%@&userId=%@&sign=%@",URL_SHOP_WEMART,wmode,WEMART_APPID,userID,sign] ;
    NSString *url = [NSString stringWithFormat:@"%@&appId=%@&userId=%@",URL_SHOP_WEMART,WEMART_APPID,userID] ;
    NSLog(@"url : %@",url) ;
    
    
    WemartMarketViewController *marketVC = [[WemartMarketViewController alloc] init] ;
    marketVC.appScheme = appScheme;
    marketVC.initialURL = url;
    [self pushViewController:marketVC animated:YES];
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

@end
