//
//  YouZanProduct.h
//  SubaoMart
//
//  Created by TuTu on 16/1/11.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YouZanProduct : NSObject

@property (nonatomic,copy) NSString *desc ;
@property (nonatomic,copy) NSString *img_url ;
@property (nonatomic,copy) NSString *link ;
@property (nonatomic,copy) NSString *title ;

- (instancetype)initWithDic:(NSDictionary *)dic ;
- (void)getImageWillShareWithShareIndex:(int)shareIndex ctrller:(UIViewController *)ctrller ;

@end
