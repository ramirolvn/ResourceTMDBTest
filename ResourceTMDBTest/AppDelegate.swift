import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.realmConfigurationToMigrate()
        if let user = UserDao.returnUser(), let expirationToken = user.token?.expires_at{
            if Date() > expirationToken{
                let deletingUser = UserDao.deleteUser(user.id)
                if !deletingUser.0{print(deletingUser.1!)}
            }else{
                let mainNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                let mainVC = mainNav.viewControllers[0] as! ViewController
                mainVC.user = user
                self.window?.rootViewController = mainNav
            }
            
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    private func realmConfigurationToMigrate(){
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
}

