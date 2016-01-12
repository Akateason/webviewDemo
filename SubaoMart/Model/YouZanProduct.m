//
//  YouZanProduct.m
//  SubaoMart
//
//  Created by TuTu on 16/1/11.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "YouZanProduct.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "ShareUtils.h"
#import "Header.h"

@implementation YouZanProduct

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _desc = dic[@"desc"] ;
        _img_url = dic[@"img_url"] ;
        _link = dic[@"link"] ;
        _title = dic[@"title"] ;
    }
    return self;
}
/*
 {
 datatype = commonShareInfo;
 desc = "\U70b9\U6211\U70b9\U6211\Uff0c\U4f60\U5fc3\U6c34\U4e48\Uff5e";
 "img_url" = "http://dn-kdt-img.qbox.me/upload_files/2015/10/12/865fc7a5806704dc9b45eab67ae0064f.jpeg";
 link = "https://shop14245510.koudaitong.com/v2/showcase/homepage?alias=v8a881k2";
 title = "\U53d1\U73b0\U4e00\U5bb6\U597d\U5e97\Uff1a\U901f\U62a5\U9171";
 }
 */

- (void)getImageWillShareWithShareIndex:(int)shareIndex ctrller:(UIViewController *)ctrller
{
    UIImage *resultImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.img_url] ;
    if (!resultImage)
    {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.img_url]
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
                                              url:self.link
                                            image:image
                                          ctrller:ctrller] ;
        }
            break;
        case 1:
        {
            [ShareUtils weixinShareFuncTitle:STR_I_WANT_BUY
                                     content:[self.title stringByAppendingString:self.desc]
                                         url:self.link
                                       image:image
                                     ctrller:ctrller] ;
        }
            break;
        case 2:
        {
            [ShareUtils wxFriendShareFuncTitle:STR_I_WANT_BUY
                                       Content:[self.title stringByAppendingString:self.desc]
                                           url:self.link
                                         image:image
                                       ctrller:ctrller] ;
        }
            break;
        default:
            break;
    }
    
}

@end
