//
//  SceneDelegate.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        start(window: window)
    }
    
    func start(window: UIWindow?) {
        window?.rootViewController = makeUITabBarController()
        window?.makeKeyAndVisible()
    }
    
    func makeUITabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            makeHomeViewController(),
            makeSettingsViewController()
        ]
        
        tabBarController.tabBar.backgroundColor = .brandLightGray
        tabBarController.selectedIndex = 0
        
        return tabBarController
    }
    
    func makeHomeViewController() -> UIViewController {
        return UINavigationController(rootViewController: HomeViewController(photoPicker: PhotoLibraryPicker()))
    }

    func makeSettingsViewController() -> UIViewController {
        return UINavigationController(rootViewController: SettingsViewController(viewModel: .init()))
    }
}

//FIXME: delete later
func makeControllerForPreview() -> UIViewController {
    SceneDelegate().makeUITabBarController()
}

#Preview {
    makeControllerForPreview()
}
