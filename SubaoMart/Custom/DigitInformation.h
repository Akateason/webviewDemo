//
//  DigitInformation.h
//  ParkingSys
//
//  Created by mini1 on 14-4-2.
//  Copyright (c) 2014年 mini1. All rights reserved.
//

#define FLOAT_HUD_MINSHOW       2.0f

#import <Foundation/Foundation.h>
#import "CurrentUser.h"


#define G_TOKEN                     [DigitInformation shareInstance].g_token
#define G_BUY_LINKS                 [DigitInformation shareInstance].g_buyLinks
#define G_CHECK_SWITCH              [DigitInformation shareInstance].g_checkSwitch

#define G_USER                      [[CurrentUser shareInstance] getCurrentUser]

@interface DigitInformation : NSObject

+ (DigitInformation *)shareInstance ;

// Global token of current user
@property (nonatomic,copy)      NSString        *g_token ;       //当前token

// UUID
@property (nonatomic,copy)      NSString        *uuid ;

// Buy Links .
@property (nonatomic,copy)      NSString        *g_buyLinks ;

// Check Switch . judge by user is installed WeiXin ios in phone .
@property (nonatomic)           BOOL            g_checkSwitch ;

@end




