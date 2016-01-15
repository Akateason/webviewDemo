//
//  UIViewController+NavExtension.m
//  SubaoMart
//
//  Created by TuTu on 16/1/9.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "UIViewController+NavExtension.h"
#import "UIImage+AddFunction.h"
#import <objc/runtime.h>
#import "SingletonSegement.h"

static const void *keyLeftButtonClickBlock  = &keyLeftButtonClickBlock  ;
static const void *keyRightButtonClickBlock = &keyRightButtonClickBlock ;
static const void *keyReplayClickBlock      = &keyReplayClickBlock ;
static const void *keyShuffleClickBlock     = &keyShuffleClickBlock ;
static const void *keySegement              = &keySegement ;

@implementation UIViewController (NavExtension)

@dynamic block_leftButtonClicked, block_rightButtonClicked, block_replay , segement ;

#pragma mark --
- (void)setSegement:(UISegmentedControl *)segement
{
    objc_setAssociatedObject(self, keySegement, segement, OBJC_ASSOCIATION_RETAIN_NONATOMIC) ;
}

- (UISegmentedControl *)segement
{
    return objc_getAssociatedObject(self, keySegement) ;
}

- (void)setBlock_leftButtonClicked:(leftButtonClickedBlock)block_leftButtonClicked
{
    objc_setAssociatedObject(self, keyLeftButtonClickBlock, block_leftButtonClicked, OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (leftButtonClickedBlock)block_leftButtonClicked
{
    return objc_getAssociatedObject(self, keyLeftButtonClickBlock) ;
}

- (void)setBlock_rightButtonClicked:(rightButtonClickedBlock)block_rightButtonClicked
{
    objc_setAssociatedObject(self, keyRightButtonClickBlock, block_rightButtonClicked, OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (rightButtonClickedBlock)block_rightButtonClicked
{
    return objc_getAssociatedObject(self, keyRightButtonClickBlock) ;
}

- (void)setBlock_replay:(replayBlock)block_replay
{
    objc_setAssociatedObject(self, keyReplayClickBlock, block_replay, OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (replayBlock)block_replay
{
    return objc_getAssociatedObject(self, keyReplayClickBlock) ;
}

- (void)setBlock_shuffle:(shuffleBlock)block_shuffle
{
    objc_setAssociatedObject(self, keyShuffleClickBlock, block_shuffle, OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (shuffleBlock)block_shuffle
{
    return objc_getAssociatedObject(self, keyShuffleClickBlock) ;
}

#pragma mark --
- (void)customNavigationBarWithUserImage:(UIImageView *)m_userImage
                              shareImage:(UIImageView *)m_shareImage
                            refreshImage:(UIImageView *)m_refreshImage
                            shuffleImage:(UIImageView *)m_shuffleImage
                            bLeftClicked:(leftButtonClickedBlock)leftBlock
                           bRightClicked:(rightButtonClickedBlock)rightBlock
                                 bReplay:(replayBlock)replayBlock
                                bShuffle:(shuffleBlock)shuffleBlock
{
    self.block_leftButtonClicked = leftBlock ;
    self.block_rightButtonClicked = rightBlock ;
    self.block_replay = replayBlock ;
    self.block_shuffle = shuffleBlock ;
    
    [self.navigationController setHidesBarsOnSwipe:YES] ;
    
    [self configureNavigationBarButtonItemsWithUserImage:m_userImage
                                              shareImage:m_shareImage
                                            refreshImage:m_refreshImage] ;

    // segement
    UISegmentedControl *segement = [[UISegmentedControl alloc] initWithItems:@[@"店铺1",@"店铺2"]] ;
    segement.tintColor = [UIColor whiteColor] ;
    segement.frame = CGRectMake(0 , 0 , 140 , 30) ;
    [segement setSelectedSegmentIndex:0] ;
    [segement addTarget:self
                  action:@selector(switchTheShop:)
        forControlEvents:UIControlEventValueChanged] ;
    self.segement = segement ;
    self.navigationItem.titleView = self.segement ;
}

- (void)switchTheShop:(UISegmentedControl *)segement
{
    int selectedInx = (int)(segement.selectedSegmentIndex) ;

    NSLog(@"selectedInx : %@",@(selectedInx)) ;
  
    self.block_shuffle(selectedInx) ;
}

- (void)configureNavigationBarButtonItemsWithUserImage:(UIImageView *)m_userImage
                                            shareImage:(UIImageView *)m_shareImage
                                          refreshImage:(UIImageView *)m_refreshImage
{
    UIButton *btUser = [[UIButton alloc] init] ;
    btUser.bounds = m_userImage.bounds ;
    [btUser addSubview:m_userImage] ;
    [btUser addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btUser] ;
    self.navigationItem.leftBarButtonItem = leftItem ;
    
    UIButton *btShare = [[UIButton alloc] init] ;
    btShare.bounds = m_shareImage.bounds ;
    [btShare addSubview:m_shareImage] ;
    [btShare addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:btShare] ;
    
    UIButton *btRefresh = [[UIButton alloc] init] ;
    btRefresh.bounds = m_refreshImage.bounds ;
    [btRefresh addSubview:m_refreshImage] ;
    [btRefresh addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside] ;
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:btRefresh] ;
    
//    UIButton *btShuffle = [[UIButton alloc] init] ;
//    btShuffle.bounds = m_refreshImage.bounds ;
//    [btShuffle addSubview:m_shuffleImage] ;
//    [btShuffle addTarget:self action:@selector(shuffle) forControlEvents:UIControlEventTouchUpInside] ;
//    UIBarButtonItem *shuffleItem = [[UIBarButtonItem alloc] initWithCustomView:btShuffle] ;
    
    UIBarButtonItem *fixedSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil] ;
    fixedSpace1.width = 20 ;
    
//    UIBarButtonItem *fixedSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil] ;
//    fixedSpace2.width = 25 ;
    
//    self.navigationItem.rightBarButtonItems = @[shareItem,fixedSpace1,refreshItem,fixedSpace2,shuffleItem] ;
    self.navigationItem.rightBarButtonItems = @[shareItem,fixedSpace1,refreshItem] ;
    
}


- (void)leftButtonClicked
{
    self.block_leftButtonClicked ;
}

- (void)rightButtonClicked
{
    self.block_rightButtonClicked ;
}

- (void)replay
{
    self.block_replay ;
}

- (void)shuffle
{
    self.block_shuffle ;
}

@end
