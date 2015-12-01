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
#import "DigitInformation.h"
#import "User.h"
#import "ServerRequest.h"

@interface NavCtrller ()
@property (nonatomic, copy) NSString *userIDStr ;
@property (nonatomic, copy) NSString *sign ;

@end

@implementation NavCtrller

- (NSString *)userIDStr
{
    return [NSString stringWithFormat:@"%d",G_USER.u_id] ;
}

- (NSString *)sign
{
    if (!_sign) {
        ResultParsered *result = [ServerRequest getWemartRsaSignWithUserID:self.userIDStr appID:WEMART_APPID] ;
        _sign = (NSString *)result.info ;
        NSLog(@"sign is : %@", _sign) ;
    }
    
    return _sign ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *appScheme = @"SubaoMart";
    NSString *url = [NSString stringWithFormat:@"%@&appId=%@&userId=%@&sign=%@",URL_SHOP_WEMART,WEMART_APPID,self.userIDStr,self.sign] ;
//    NSString *url = [NSString stringWithFormat:@"%@&appId=%@&userId=%@",URL_SHOP_WEMART,WEMART_APPID,self.userIDStr] ;
    NSLog(@"url : %@",url) ;
    
    WemartMarketViewController *marketVC = [[WemartMarketViewController alloc] init] ;
    marketVC.appScheme = appScheme ;
    marketVC.initialURL = url ;
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
