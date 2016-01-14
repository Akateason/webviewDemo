//
//  CurrentUser.m
//  SubaoMart
//
//  Created by TuTu on 16/1/13.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "CurrentUser.h"
#import "ResultParsered.h"
#import "DigitInformation.h"
#import "ServerRequest.h"
#import "XTFileManager.h"
#import "Header.h"
#import "YZUserModel.h"

static NSString *k_key_currentUserDictionary = @"CurrentUser" ;


@implementation CurrentUser

static CurrentUser *instance ;
static dispatch_once_t onceToken ;
+ (id)shareInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CurrentUser alloc] init] ;
    }) ;
    
    return instance ;
}

- (BOOL)isLogined
{
    return (G_TOKEN != nil) ;
}

- (BOOL)currentUserExist
{
    if ([self getCurrentUserDictionaryFromDisk] != nil || ![[self getCurrentUserDictionaryFromDisk] isEqual:@{}])
    {
        return NO ;
    }
    
    return YES ;
}

//cache dic for key "CurrentUser"
- (void)cacheUserByDictionary:(NSDictionary *)userDic
{
    [[NSUserDefaults standardUserDefaults] setObject:userDic
                                              forKey:k_key_currentUserDictionary] ;
}

// use it when current user logout .
- (void)removeCurrentUser
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_key_currentUserDictionary] ;
}

- (NSDictionary *)getCurrentUserDictionaryFromDisk
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:k_key_currentUserDictionary] ;
}

- (User *)getCurrentUserFromDisk
{
    return [[User alloc] initWithDic:[self getCurrentUserDictionaryFromDisk]] ;
}

- (User *)getCurrentUserFromServer // sync.
{
    // 1. get from server
    ResultParsered *result = [ServerRequest getMyIndexPersonalInfo] ;
    if (!result) return nil ;
    // 2. save in disk
    [self cacheUserByDictionary:result.info] ;
    
    return [[User alloc] initWithDic:result.info] ;
}

- (User *)getCurrentUser
{
    if ([self currentUserExist])
    {
        return [self getCurrentUserFromDisk] ;
    }
    else
    {
        if (!G_TOKEN)
        {
            NSLog(@"未登录") ;
            return nil ;
        }
        else
        {
            return [self getCurrentUserFromServer] ;
        }
    }
    
    return nil ;
}


- (void)login:(ResultParsered *)result
{
    [self login:result completion:nil] ;
}

- (void)login:(ResultParsered *)result completion:(void (^ __nullable)())completion
{
    if (result.errCode) {
        NSLog(@"err code : %@",result.message) ;
        NSLog(@"登陆失败") ;
        return;
    }
    
    // clear current info .
    G_TOKEN = nil ;
    G_BUY_LINKS = nil ;
    [[CurrentUser shareInstance] removeCurrentUser] ;
    
    dispatch_queue_t queue = dispatch_queue_create("loginWithTokenAndCacheUser", NULL) ;
    dispatch_async(queue, ^{
        // get token .
        G_TOKEN = [result.info objectForKey:@"token"];
        
        // get user info from server .
        [[CurrentUser shareInstance] getCurrentUserFromServer] ;
        
        if (completion) {
            completion() ;
        }

    }) ;
}

- (void)logout
{
    // exit my account
    G_TOKEN         = nil ;
    [[CurrentUser shareInstance] removeCurrentUser] ;
    
    // del the archive
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:PATH_TOKEN_SAVE] ;
    [XTFileManager deleteFileWithFileName:path] ;
}

+ (YZUserModel *)getYZUserModelFromCacheUser:(User *)cacheModel
{
    YZUserModel *userModel = [[YZUserModel alloc] init] ;
    userModel.userID = [NSString stringWithFormat:@"%d",cacheModel.u_id] ;
    userModel.userName = cacheModel.u_nickname ;
    userModel.nickName = cacheModel.u_nickname ;
    userModel.gender = [NSString stringWithFormat:@"%d",cacheModel.gender] ;
    userModel.avatar = cacheModel.u_headpic;
    userModel.telePhone = @"" ;
    return userModel;
}


@end












