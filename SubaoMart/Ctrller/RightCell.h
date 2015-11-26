//
//  RightCell.h
//  SubaoMart
//
//  Created by TuTu on 15/11/26.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat  ROW_HEIGHT  = 85.0 ;
static CGFloat  IMG_SIDE    = 40.0 ;

@interface RightCell : UITableViewCell
@property (nonatomic, copy , nonnull) NSString *imgStr ;
@property (nonatomic, copy , nonnull) NSString *textStr ;
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(nullable NSString *)reuseIdentifier ;
- (void)scaleAnimation ;
@end
