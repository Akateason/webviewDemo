//
//  SingletonSegement.m
//  SubaoMart
//
//  Created by TuTu on 16/1/14.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SingletonSegement.h"

@implementation SingletonSegement

static SingletonSegement *instance ;
static dispatch_once_t onceToken ;

+ (SingletonSegement *)shareInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init] ;
    }) ;
    return instance;
}


@end
