//
//  SceneDelegate.swift
//  AuthorisationApp
//
//  Created by Matvei Khlestov on 29.05.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let appModel = AppModel()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        if appModel.isUserLogin() {
            setRootViewController(
                UINavigationController(
                    rootViewController: NotesViewController()
                )
            )
        } else {
            setRootViewController(RegistrationViewController())
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .showSignIn,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .showProfile,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .showRegister,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .showNotes,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .showAddNotes,
            object: nil
        )
    }
    
    @objc func handleNotification(_ notification: Notification) {
        switch notification.name {
        case .showSignIn:
            setRootViewController(SignInViewController())
        case .showProfile:
            setRootViewController(UINavigationController(
                rootViewController: ProfileViewController()
            ))
        case .showNotes:
            setRootViewController(UINavigationController(
                rootViewController: NotesViewController()
            ))
            
        case .showAddNotes:
            setRootViewController(UINavigationController(
                rootViewController: AddNotesViewController()
            ))
        default:
            setRootViewController(RegistrationViewController())
        }
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
}

