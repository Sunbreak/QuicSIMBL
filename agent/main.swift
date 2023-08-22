import Foundation
import Cocoa
import os.log

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        os_log("QuicSIMBLAgent didFinishLaunchingWithOptions")
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(didReceiveLaunch(notification:)), name: NSWorkspace.didLaunchApplicationNotification, object: nil)
    }
    
    @objc func didReceiveLaunch(notification: Notification) {
        os_log("QuicSIMBLAgent didReceiveLaunchNotification %{public}@", notification.userInfo!.description)
    }
}

NSApplication.shared.delegate = AppDelegate()

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
