//
//  RootMenu.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "RootMenu.h"
#import "LeftCtrller.h"
#import "RightCtrller.h"
#import "Header.h"
#import "NavCtrller.h"
#import "DigitInformation.h"
#import "YouzanViewController.h"

@interface RootMenu ()

@property (nonatomic,strong) LeftCtrller    *leftC  ;
@property (nonatomic,strong) RightCtrller   *rightC ;

@property (nonatomic,strong) UINavigationController *youzanNav ;
@property (nonatomic,strong) NavCtrller             *weimaoNav ;

@end

@implementation RootMenu
#pragma mark --
- (UINavigationController *)youzanNav
{
    if (!_youzanNav) {
        YouzanViewController *youzanCtrller = [[YouzanViewController alloc] init] ;
        _youzanNav = [[UINavigationController alloc] initWithRootViewController:youzanCtrller] ;
    }
    return _youzanNav ;
}

- (NavCtrller *)weimaoNav
{
    if (!_weimaoNav) {
        _weimaoNav = [[NavCtrller alloc] init] ;
    }
    return _weimaoNav ;
}

#pragma mark --
- (void)operateSlider:(NSNotification *)notification
{
    NSNumber *number = notification.object ;
    if ([number intValue] == 1) {
        [self presentLeftMenuViewController] ;
    }
    else if ([number intValue] == 2) {
        [self presentRightMenuViewController] ;
    }
}

- (void)shuffleCallback:(NSNotification *)notification
{
    NSString *backString = notification.object ;

    if ([backString isEqualToString:WM_SHUFFLE_NOTIFICAITON]) {
        self.contentViewController  = self.youzanNav ;
    }
    else if ([backString isEqualToString:YZ_SHUFFLE_NOTIFICAITON]) {
        self.contentViewController  = self.weimaoNav ;
    }
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(operateSlider:)
                                                     name:SLIDER_NOTIFICATION
                                                   object:nil] ;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(shuffleCallback:)
                                                     name:SHUFFLE_NOTIFICAITON
                                                   object:nil] ;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLIDER_NOTIFICATION object:nil] ;
}

#pragma mark --
- (void)awakeFromNib
{
    [super awakeFromNib] ;
    
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(1, 1);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.backgroundImage = [UIImage imageNamed:@"back3.jpg"];
    
    self.contentViewController  = self.youzanNav ;

    
    self.leftC = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftCtrller"] ;
    self.leftMenuViewController = self.leftC ;
    self.rightC = [self.storyboard instantiateViewControllerWithIdentifier:@"RightCtrller"] ;
    self.rightMenuViewController = self.rightC ;
    
    self.delegate = self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    NSLog(@"G_CHECK_SWITCH : %d",G_CHECK_SWITCH) ;
    
    self.panGestureEnabled = G_CHECK_SWITCH ;
    
    self.contentViewController  = G_CHECK_SWITCH ? self.youzanNav : self.weimaoNav ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    if ([NSStringFromClass([menuViewController class]) hasPrefix:@"Left"]) {
        [self.leftC popupAnimaton] ;
    }
    else if ([NSStringFromClass([menuViewController class]) hasPrefix:@"Right"]) {
        [self.rightC showAnimation] ;
    }
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
    [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_MENU_NOTIFICATION object:nil] ;
}

@end
