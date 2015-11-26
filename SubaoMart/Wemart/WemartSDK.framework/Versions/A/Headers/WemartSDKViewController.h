//
//  WemartSDKViewController.h
//  WemartSDKDemo
//
//  Created by DongYifan on 5/16/15.
//  Copyright (c) 2015 Wemart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WemartSDKViewController : UIViewController
@property (nonatomic, strong) NSString * initialURL;
@property (nonatomic, strong) NSString * appScheme;

-(NSString *) getSharedData;
@end
