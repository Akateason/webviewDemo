//
//  WemartProduct.m
//  SubaoMart
//
//  Created by TuTu on 15/12/1.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "WemartProduct.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@implementation WemartProduct

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
