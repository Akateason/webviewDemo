//
//  DigitInformation.h
//  ParkingSys
//
//  Created by mini1 on 14-4-2.
//  Copyright (c) 2014年 mini1. All rights reserved.
//

#define FLOAT_HUD_MINSHOW       2.0f

#import <Foundation/Foundation.h>
@class User ;

#define G_TOKEN                     [DigitInformation shareInstance].g_token
#define G_USER                      [DigitInformation shareInstance].g_user

@interface DigitInformation : NSObject

+ (DigitInformation *)shareInstance ;

#pragma mark --
// global token of current user
@property (nonatomic,copy)      NSString        *g_token ;       //当前token

// UUID
@property (nonatomic,copy)      NSString        *uuid ;

// user current
@property (nonatomic,strong)    User            *g_user ;

@end




