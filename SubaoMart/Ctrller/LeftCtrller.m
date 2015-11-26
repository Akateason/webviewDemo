//
//  LeftCtrller.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "LeftCtrller.h"
#import "UIViewController+RESideMenu.h"
#import "ShoppingCtrller.h"
#import "Header.h"
#import "XTAnimation.h"

int const      NUM_LOGIN  = 2 ;
static CGFloat ROW_HEIGHT = 75.0 ;
static CGFloat heightHead = 60.0f ;
#define        flex         APPFRAME.size.height / 2.0 - heightHead / 2.0       // 150.0f ;

@interface LeftCtrller ()
@property (strong, nonatomic) UITableView *tableView ;
@property (strong, nonatomic) UIImageView *headImage ;
@property (strong, nonatomic) UILabel     *nameLabel ;
@end

@implementation LeftCtrller

- (UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, heightHead , heightHead )] ;
        _headImage.image = [UIImage imageNamed:@"2"] ;
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
        _nameLabel.frame = rectName ;
        _nameLabel.text = @"呵呵哒" ;
        _nameLabel.textColor = [UIColor whiteColor] ;
        _nameLabel.font = [UIFont systemFontOfSize:16.0] ;
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
                                                                   ROW_HEIGHT * NUM_LOGIN + heightHead + flex)
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
        if (![_tableView superview]) {
            [self.view addSubview:_tableView] ;
        }
    }
    
    return _tableView ;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = nil ;
    [self tableView] ;
}

- (void)popupAnimaton
{
    static CGFloat durationShake = 0.56 ;
    [XTAnimation shakeRandomDirectionWithDuration:durationShake AndWithView:self.headImage] ;
    [XTAnimation shakeRandomDirectionWithDuration:durationShake AndWithView:self.nameLabel] ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    [UIView animateWithDuration:1.0
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
            // login 1
        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
    
    
//    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return NUM_LOGIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
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
