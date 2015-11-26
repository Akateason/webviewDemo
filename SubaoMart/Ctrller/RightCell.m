//
//  RightCell.m
//  SubaoMart
//
//  Created by TuTu on 15/11/26.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "RightCell.h"
#import "Header.h"
#import "XTAnimation.h"

@interface RightCell ()
@property (nonatomic,strong) UIImageView *imgView ;
@property (nonatomic,strong) UILabel *label ;
@end

@implementation RightCell

- (void)scaleAnimation
{
    [XTAnimation smallBigBestInCell:self.imgView sideRate:0.86 duration:0.18] ;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self)
    {
        self.backgroundColor = nil ;
        self.selectedBackgroundView = [[UIView alloc] init] ;
        [self imgView] ;
        [self label] ;
    }
    
    return self ;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init] ;
        _imgView.frame = CGRectMake(APPFRAME.size.width - IMG_SIDE - 20 , 0, IMG_SIDE, IMG_SIDE) ;
//        _imgView.image = [UIImage imageNamed:images[indexPath.row]] ;
        if (![_imgView superview]) {
            [self.contentView addSubview:_imgView] ;
        }
    }
    
    return _imgView ;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init] ;
        CGRect labelRect = CGRectMake(0 , 0, self.imgView.frame.origin.x - 20.0 , IMG_SIDE) ;
        _label.frame = labelRect ;
        _label.textAlignment = NSTextAlignmentRight ;
        //label.text = titles[indexPath.row] ;
        _label.textColor = [UIColor whiteColor] ;
        _label.highlightedTextColor = [UIColor lightGrayColor] ;
        _label.font = [UIFont systemFontOfSize:16.0] ;
        if (![_label superview]) {
            [self.contentView addSubview:_label] ;
        }
    }
    
    return _label ;
}

- (void)setImgStr:(NSString *)imgStr
{
    _imgStr = imgStr ;
    
    self.imgView.image = [UIImage imageNamed:imgStr] ;
}

- (void)setTextStr:(NSString *)textStr
{
    _textStr = textStr ;
    
    self.label.text = textStr ;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
