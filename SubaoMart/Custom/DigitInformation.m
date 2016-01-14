





#import "DigitInformation.h"
#import "ServerRequest.h"
#import "XTFileManager.h"
#import "Header.h"
#import "User.h"
#import "WXApi.h"

static DigitInformation *instance ;
static dispatch_once_t  onceToken ;

@implementation DigitInformation

@synthesize g_token = _g_token ;

+ (DigitInformation *)shareInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[DigitInformation alloc] init];
    });

    return instance;
}

#pragma mark --
#pragma mark - Setter
- (void)setG_token:(NSString *)g_token
{
    _g_token = g_token ;
    
    if (g_token != nil) {
        // cache token by archive .
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:PATH_TOKEN_SAVE] ;
        [XTFileManager archiveTheObject:G_TOKEN AndPath:path] ;
    }
    
    
}

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

- (BOOL)g_checkSwitch
{
    _g_checkSwitch = [WXApi isWXAppInstalled] ;

    return _g_checkSwitch ;
}

@end


