//
//  AppDelegate.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "AppDelegate.h"
#import <WemartSDK/WemartSDK.h>
#import "UIImage+AddFunction.h"
#import "Header.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
//    {
//        self.window.clipsToBounds = YES ;
//        self.window.frame = CGRectMake(0, 20,self.window.frame.size.width,self.window.frame.size.height - 20) ;
//        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height) ;
//    }

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent] ;
    [[UIApplication sharedApplication] keyWindow].tintColor = COLOR_MAIN ;

    
    //2 nav style
    [[UINavigationBar appearance] setBarTintColor:COLOR_MAIN] ;
    
    //  nav word style
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}] ;
    
    //  status bar style
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]] ;
    [[UINavigationBar appearance] setBackgroundColor:COLOR_MAIN] ;


    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [WemartSDK handleAppCallback:url];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
