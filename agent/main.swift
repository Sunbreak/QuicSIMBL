import Foundation
import Cocoa
import os.log

NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.didLaunchApplicationNotification, object: nil, queue: OperationQueue.main) { notification in
    os_log("QuicSIMBLAgent didReceiveLaunchNotification %{public}@", notification.userInfo!.description)
}

RunLoop.main.run()
