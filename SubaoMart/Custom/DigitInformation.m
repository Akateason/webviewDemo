





#import "DigitInformation.h"
#import "ServerRequest.h"
#import "XTFileManager.h"
#import "Header.h"


static DigitInformation *instance ;
static int timeCount = 0 ;

@implementation DigitInformation

+ (DigitInformation *)shareInstance
{
    if (instance == nil) {
        instance = [[[self class] alloc] init];
    }
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



@end


