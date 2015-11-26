//
//  WemartSDK.h
//  WemartSDK
//
//  Created by DongYifan on 5/21/15.
//  Copyright (c) 2015 Wemart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WemartSDK/WemartSDKViewController.h>

@interface WemartSDK : NSObject

+(BOOL)handleAppCallback:(NSURL *)url;

@end
