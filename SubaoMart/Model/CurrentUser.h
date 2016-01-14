//
//  CurrentUser.h
//  SubaoMart
//
//  Created by TuTu on 16/1/13.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "User.h"
@class YZUserModel ;
@class ResultParsered ;


@interface CurrentUser : User

+ (id)shareInstance ;

- (BOOL)isLogined ;

- (BOOL)currentUserExist; //In Disk  current user exist or not .

- (void)cacheUserByDictionary:(NSDictionary *)userDic ; //cache dic for key "CurrentUser"

- (void)removeCurrentUser ; // use it when current user logout .

- (NSDictionary *)getCurrentUserDictionaryFromDisk ;

- (User *)getCurrentUser ;

- (void)login:(ResultParsered *)result ;
- (void)login:(ResultParsered *)result completion:(void (^ __nullable)())completion ;
- (void)logout ;

+ (YZUserModel *)getYZUserModelFromCacheUser:(User *)cacheModel ;

@end
