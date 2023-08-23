#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [NSWorkspace.sharedWorkspace.notificationCenter addObserverForName:NSWorkspaceDidLaunchApplicationNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            NSLog(@"QuicSIMBLAgent didReceiveLaunchNotification %@", note.userInfo);
        }];
        [NSRunLoop.mainRunLoop run];
    }
    return 0;
}
