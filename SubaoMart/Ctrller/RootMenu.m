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


@interface RootMenu ()
@property (nonatomic,strong) LeftCtrller    *leftC  ;
@property (nonatomic,strong) RightCtrller   *rightC ;
@end

@implementation RootMenu

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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(operateSlider:)
                                                     name:SLIDER_NOTIFICATION
                                                   object:nil] ;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SLIDER_NOTIFICATION object:nil] ;
}

- (void)awakeFromNib
{
    [super awakeFromNib] ;
    
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(1, 1);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    
    self.contentViewController  = [[NavCtrller alloc] init] ;
    self.backgroundImage = [UIImage imageNamed:@"back3.jpg"];
    
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
    
    self.panGestureEnabled = G_CHECK_SWITCH ;
    
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
}

@end
