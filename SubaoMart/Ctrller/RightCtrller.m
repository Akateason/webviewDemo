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
#import "RightCell.h"
#import "ShareUtils.h"
#import "DigitInformation.h"

int const       NUM_SHARE   = 3 ;

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
        RightCell *cell = (RightCell *)[self.tableView cellForRowAtIndexPath:indexPath] ;
        [cell scaleAnimation] ;
    }
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_R_NOTIFICATION object:@(indexPath.row)] ;
    
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
    static NSString *cellIdentifier = @"RightCell";
    
    RightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[RightCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:cellIdentifier] ;
    }
    
    NSArray *titles = @[@"分享到微博", @"分享到微信", @"分享到朋友圈"];
    NSArray *images = @[@"share_weibo", @"share_weixin", @"share_friend"];
    
    cell.textStr = titles[indexPath.row] ;
    cell.imgStr = images[indexPath.row] ;
    
    return cell ;
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
