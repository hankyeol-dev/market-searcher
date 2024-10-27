//
//  SceneDelegate.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   var window: UIWindow?
   var networkMonitorService: NetworkMonitorService?
   
   func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      guard let scene = (scene as? UIWindowScene) else { return }
      window = UIWindow(windowScene: scene)
      networkMonitorService = .manager
      window?.rootViewController = User.isSavedUser
      ? MainTabBarController()
      : UINavigationController(rootViewController: OnboardingMainViewController())
      window?.makeKeyAndVisible()
      
      networkMonitorService?.startMonitoring { [weak self] isNetworkConnected in
         if isNetworkConnected {
            self?.displayReconnectWindow()
         } else {
            self?.displayNetworkConnectionErrorView(scene)
         }
      }
   }
   
   func sceneDidDisconnect(_ scene: UIScene) {
      networkMonitorService?.stopMonitoring()
      networkMonitorService = nil
   }
   
   func sceneDidBecomeActive(_ scene: UIScene) {}
   
   func sceneWillResignActive(_ scene: UIScene) {}
   
   func sceneWillEnterForeground(_ scene: UIScene) {}
   
   func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
   private func displayNetworkConnectionErrorView(_ scene: UIScene) {
      guard let scene = scene as? UIWindowScene else { return }
      window = UIWindow(windowScene: scene)
      window?.windowLevel = .normal
      window?.addSubview(NetworkErrorView(frame: window?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 300)))
      window?.makeKeyAndVisible()
   }
   
   private func displayReconnectWindow() {
      window?.rootViewController = User.isSavedUser
      ? MainTabBarController()
      : UINavigationController(rootViewController: OnboardingMainViewController())
      window?.makeKeyAndVisible()
   }
}
