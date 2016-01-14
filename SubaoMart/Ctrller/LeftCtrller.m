//
//  LeftCtrller.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "LeftCtrller.h"
#import "UIViewController+RESideMenu.h"
#import "Header.h"
#import "KeyChainHeader.h"
#import "XTAnimation.h"
#import "UMSocial.h"
#import "ServerRequest.h"
#import "User.h"
#import "DigitInformation.h"
#import "UIImageView+WebCache.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import "CurrentUser.h"

int const      NUM_LOGIN  = 2 ;
static CGFloat ROW_HEIGHT = 75.0 ;
static CGFloat heightHead = 60.0f ;
#define        flex         APPFRAME.size.height / 2.0 - heightHead / 2.0

@interface LeftCtrller ()

@property (strong, nonatomic) UITableView *tableView ;
@property (strong, nonatomic) UIImageView *headImage ;
@property (strong, nonatomic) UILabel     *nameLabel ;

@end

@implementation LeftCtrller

#pragma mark --
#pragma mark - Initialization
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder] ;
    if (self) {
        ((AppDelegate *)([UIApplication sharedApplication].delegate)).leftctrller = self ;
    }
    
    return self ;
}


#pragma mark --
#pragma mark - Properties
- (UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, heightHead , heightHead )] ;

        [_headImage sd_setImageWithURL:[NSURL URLWithString:G_USER.u_headpic]
                      placeholderImage:[UIImage imageNamed:@"2"]] ;
        
        _headImage.layer.cornerRadius = (heightHead) / 2.0 ;
        _headImage.layer.masksToBounds = YES ;
        _headImage.layer.borderWidth = 1.0f ;
        _headImage.layer.borderColor = [UIColor whiteColor].CGColor ;
    }
    
    return _headImage ;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init] ;
        CGRect rectName = self.headImage.frame ;
        rectName.origin.x += ( 20 + self.headImage.frame.size.width ) ;
        rectName.size.width = 200 ;
        _nameLabel.frame = rectName ;
        _nameLabel.text = !G_USER.u_id ? @"未登录" : G_USER.u_nickname ; 
        _nameLabel.textColor = [UIColor whiteColor] ;
        _nameLabel.font = [UIFont boldSystemFontOfSize:17.0] ;
    }
    
    return _nameLabel ;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, heightHead + flex)] ;
        
        if (![self.headImage superview]) {
            [header addSubview:self.headImage] ;
        }
        if (![self.nameLabel superview]) {
            [header addSubview:self.nameLabel] ;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,
                                                                   APPFRAME.size.height / 14 ,
                                                                   self.view.frame.size.width ,
                                                                   ROW_HEIGHT * NUM_LOGIN + heightHead + flex )
                                                  style:UITableViewStylePlain] ;
        _tableView.tableHeaderView = header ;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.opaque = NO ;
        _tableView.backgroundColor = nil ;
        _tableView.backgroundView = nil ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.bounces = NO ;
        _tableView.scrollsToTop = NO ;
    }
    
    if (![_tableView superview]) {
        [self.view addSubview:_tableView] ;
    }
    
    return _tableView ;
}

#pragma mark -
#pragma mark -- public
- (void)refreshUserInfo
{
    _nameLabel.text = !G_USER.u_id ? @"未登录" : G_USER.u_nickname ;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:G_USER.u_headpic]
                  placeholderImage:[UIImage imageNamed:@"2"]] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = nil ;
    [self tableView] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;

    [self refreshUserInfo] ;
    [self.tableView reloadData] ;
}

- (void)popupAnimaton
{
    CABasicAnimation *animation = [XTAnimation horizonRotationWithDuration:0.16 degree:180 direction:1 repeatCount:2] ;
    for (int i = 0; i < 2; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] ;
        [cell.imageView.layer addAnimation:animation forKey:@"round"] ;
    }
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    [UIView animateWithDuration:0.8
                     animations:^{
                         [XTAnimation animationRippleEffect:cell] ;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self loginWithIndex:(int)indexPath.row] ;
                         }
                     }] ;

}

- (void)loginWithIndex:(int)index
{
    switch (index) {
        case 0:
        {
            [self weiboLoginAction] ;
        }
            break;
        case 1:
        {
            [self weixinLoginAction] ;
        }
            break;
        default:
            break;
    }
}

- (void)weiboLoginAction
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request] ;
    request.redirectURI = WB_REDIRECTURL ;
    request.scope = @"all" ;
    [WeiboSDK sendRequest:request] ;
}

- (void)weixinLoginAction
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
                
                NSString *openID = [response.data objectForKey:@"openid"] ;
                NSNumber *gender = [response.data objectForKey:@"gender"] ;
                NSString *head   = [response.data objectForKey:@"profile_image_url"] ;
                
                [ServerRequest loginUnitWithCategory:mode_WeiXin wxopenID:openID wxUnionID:snsAccount.unionId nickName:snsAccount.userName gender:gender language:nil country:nil province:nil city:nil headpic:head wbuid:nil description:nil username:nil password:nil Success:^(id json) {
                    
                    ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                    [[CurrentUser shareInstance] login:result completion:^{
                        [self refreshUserInfo] ;
                        [self.tableView reloadData] ;
                    }] ;
                    
                } fail:^{
                    NSLog(@"failed") ;
                }] ;
                
            }];
        }
        
    });
}

#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return NUM_LOGIN ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShareCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    NSArray *titles = @[@"微博登录", @"微信登录"];
    NSArray *images = @[@"login_weibo", @"login_weixin"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
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
