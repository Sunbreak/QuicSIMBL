#import <Foundation/Foundation.h>

@interface QuicSIMBLAddition : NSObject
@end

@implementation QuicSIMBLAddition

OSErr injectEventHandler(const AppleEvent *ev, AppleEvent *reply, long refcon) {
    NSLog(@"QuicSIMBLAddition injectEventHandler");
    return noErr;
}

@end