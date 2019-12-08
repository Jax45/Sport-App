import UIKit

// NOTE: - Helper functions for programmatically instantiating your ViewControllers in the TabBar
extension UINavigationController {
    static func with(storyboardName: String) -> UINavigationController {
        return UIStoryboard(name: storyboardName, bundle: .main).instantiateInitialViewController() as! UINavigationController
    }
    
    // This generic function returns the UINavigationController's root ViewController as the specified type
    func rootViewController<T: UIViewController>(asType type: T.Type) -> T {
        return self.viewControllers.first as! T
    }
}

