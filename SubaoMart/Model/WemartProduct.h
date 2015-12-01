//
//  WemartProduct.h
//  SubaoMart
//
//  Created by TuTu on 15/12/1.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WemartProduct : NSObject

@property (nonatomic,copy)      NSString    *title ;
@property (nonatomic,copy)      NSString    *content ;
@property (nonatomic,copy)      NSString    *shareUrl ;
@property (nonatomic,copy)      NSString    *thumbData ;

- (instancetype)initWithDic:(NSDictionary *)dic ;

@end
