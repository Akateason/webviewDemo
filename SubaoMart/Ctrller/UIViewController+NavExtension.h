//
//  UIViewController+NavExtension.h
//  SubaoMart
//
//  Created by TuTu on 16/1/9.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^leftButtonClickedBlock)() ;
typedef void (^rightButtonClickedBlock)() ;
typedef void (^replayBlock)() ;
typedef void (^shuffleBlock)() ;

@interface UIViewController (NavExtension)

@property (nonatomic,copy) leftButtonClickedBlock   block_leftButtonClicked ;
@property (nonatomic,copy) rightButtonClickedBlock  block_rightButtonClicked ;
@property (nonatomic,copy) replayBlock              block_replay ;
@property (nonatomic,copy) shuffleBlock             block_shuffle ;

- (void)customNavigationBarWithUserImage:(UIImageView *)m_userImage
                              shareImage:(UIImageView *)m_shareImage
                            refreshImage:(UIImageView *)m_refreshImage
                            shuffleImage:(UIImageView *)m_shuffleImage
                            bLeftClicked:(leftButtonClickedBlock)leftBlock
                           bRightClicked:(rightButtonClickedBlock)rightBlock
                                 bReplay:(replayBlock)replayBlock
                                bShuffle:(shuffleBlock)shuffleBlock ;

- (void)customNavigationBarWithShareImage:(UIImageView *)m_shareImage
                            bRightClicked:(rightButtonClickedBlock)rightBlock ;

@end
