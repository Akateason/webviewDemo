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
#import "ShareUtils.h"
#import "Header.h"

@implementation WemartProduct

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic] ;
    }
    return self;
}

- (void)getImageWillShareWithShareIndex:(int)shareIndex ctrller:(UIViewController *)ctrller
{
    UIImage *resultImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.thumbData] ;
    if (!resultImage)
    {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.thumbData]
                                                              options:0
                                                             progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                
                                                                [self shareFuncWithImage:image
                                                                                   index:shareIndex
                                                                                 ctrller:ctrller] ;
                                                                
                                                            }] ;
    }
    else
    {
        [self shareFuncWithImage:resultImage
                           index:shareIndex
                         ctrller:ctrller] ;
    }

}

- (void)shareFuncWithImage:(UIImage *)image
                     index:(int)index
                   ctrller:(UIViewController *)ctrller
{
    switch (index)
    {
        case 0:
        {
            [ShareUtils weiboShareFuncWithContent:STR_I_WANT_BUY
                                              url:self.shareUrl
                                            image:image
                                          ctrller:ctrller] ;
        }
            break;
        case 1:
        {
            [ShareUtils weixinShareFuncTitle:STR_I_WANT_BUY
                                     content:[self.title stringByAppendingString:self.content]
                                         url:self.shareUrl
                                       image:image
                                     ctrller:ctrller] ;
        }
            break;
        case 2:
        {
            [ShareUtils wxFriendShareFuncTitle:STR_I_WANT_BUY
                                       Content:[self.title stringByAppendingString:self.content]
                                           url:self.shareUrl
                                         image:image
                                       ctrller:ctrller] ;
        }
            break;
        default:
            break;
    }

}

@end
