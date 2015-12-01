//
//  AppDelegateInitial.h
//  SubaoMart
//
//  Created by TuTu on 15/11/26.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppDelegateInitial : NSObject

- (instancetype)initWithApplication:(UIApplication *)application
                            options:(NSDictionary *)launchOptions
                             window:(UIWindow *)window ;

- (void)setup ;

@end
