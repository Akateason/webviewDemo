//
//  LeftCtrller.h
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

// Login Ctrller

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface LeftCtrller : UIViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

- (void)popupAnimaton ;
- (void)refreshUserInfo ;

@end
