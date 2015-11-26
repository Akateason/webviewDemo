//
//  RightCtrller.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "RightCtrller.h"
#import "Header.h"
#import "XTAnimation.h"

static CGFloat  ROW_HEIGHT  = 85.0 ;
int const       NUM_SHARE   = 3 ;

static CGFloat  IMG_SIDE    = 40.0 ;


@interface RightCtrller ()
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation RightCtrller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = nil ;
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (APPFRAME.size.height - ROW_HEIGHT * NUM_SHARE) / 2.0f, self.view.frame.size.width, ROW_HEIGHT * NUM_SHARE) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    }) ;
    [self.view addSubview:self.tableView] ;
}

- (void)showAnimation
{
    for (int i = 0; i < 3; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0] ;
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
        [XTAnimation smallBigBestInCell:cell] ;
    }
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    
//    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return NUM_SHARE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"分享到微博", @"分享到微信", @"分享到朋友圈"];
    NSArray *images = @[@"share_weibo", @"share_weixin", @"share_friend"];
    
    UIImageView *imageView = [[UIImageView alloc] init] ;
    imageView.frame = CGRectMake(APPFRAME.size.width - IMG_SIDE - 20 , 0, IMG_SIDE, IMG_SIDE) ;
    imageView.image = [UIImage imageNamed:images[indexPath.row]] ;
    [cell addSubview:imageView] ;
    
    UILabel *label = [[UILabel alloc] init] ;
    CGRect labelRect = imageView.frame ;
    labelRect.origin.x      = 0 ;
    labelRect.size.width    = imageView.frame.origin.x - 20.0 ;
    label.frame = labelRect ;
    label.textAlignment = NSTextAlignmentRight ;
    label.text = titles[indexPath.row] ;
    label.textColor = [UIColor whiteColor] ;
    label.highlightedTextColor = [UIColor lightGrayColor] ;
    label.font = [UIFont systemFontOfSize:16.0] ;
    [cell addSubview:label] ;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
