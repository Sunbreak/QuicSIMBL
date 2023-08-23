#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"QuicSIMBLAgent main");
        [NSWorkspace.sharedWorkspace.notificationCenter addObserverForName:NSWorkspaceDidLaunchApplicationNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            NSLog(@"QuicSIMBLAgent didReceiveLaunchNotification %@", note.userInfo);

            pid_t pid = [note.userInfo[@"NSApplicationProcessIdentifier"] intValue];
            SBApplication *bridgeApp = [SBApplication applicationWithProcessIdentifier:pid];

            bridgeApp.sendMode = kAENoReply | kAENeverInteract | kAEDontRecord;
            [bridgeApp sendEvent:'SIMe' id:'load' parameters:0];
        }];
        [NSRunLoop.mainRunLoop run];
    }
    return 0;
}
