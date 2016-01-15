//
//  SingletonSegement.h
//  SubaoMart
//
//  Created by TuTu on 16/1/14.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingletonSegement : NSObject

+ (SingletonSegement *)shareInstance ;

@property (nonatomic) int selectedIndex ;

@end
