





#import "DigitInformation.h"
#import "ServerRequest.h"
#import "XTFileManager.h"
#import "Header.h"
#import "User.h"
#import "WXApi.h"

static DigitInformation *instance ;
static dispatch_once_t  onceToken ;

@implementation DigitInformation

+ (DigitInformation *)shareInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[DigitInformation alloc] init];
    });

    return instance;
}

#pragma mark --
#pragma mark - Setter

#pragma mark --
#pragma mark - Getter
- (NSString *)g_token
{
    if (!_g_token)
    {
        NSString *homePath = NSHomeDirectory() ;
        NSString *path     = [homePath stringByAppendingPathComponent:PATH_TOKEN_SAVE] ;
        if ([XTFileManager is_file_exist:path]) {
            NSString *token = [XTFileManager getObjUnarchivePath:path] ;
            _g_token        = token ;
            NSLog(@"token exist : %@",token) ;
        }
        else {
            NSLog(@"未登录") ;
        }
    }
    
    return _g_token ;
}


#define KEY_UUID            @"uuid"

- (NSString *)uuid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _uuid = [userDefaults objectForKey:KEY_UUID] ;
    if (!_uuid)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        //    NSString *uuid = (NSString *)CFUUIDCreateString(kCFAllocatorDefault,uuidRef) ;
        _uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef)) ;
        CFRelease(uuidRef) ;
        [userDefaults setObject:_uuid forKey:KEY_UUID];
    }
    
    return _uuid ;
}

- (User *)g_user
{
    if (!_g_user) {
        ResultParsered *result = [ServerRequest getMyIndexPersonalInfo] ;
        if (!result) return nil ;
        _g_user = [[User alloc] initWithDic:result.info] ;
    }
    
    return _g_user ;
}

- (BOOL)g_checkSwitch
{
    _g_checkSwitch = [WXApi isWXAppInstalled] ;

    return _g_checkSwitch ;
}

@end


