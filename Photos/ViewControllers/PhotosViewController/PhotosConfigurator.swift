//
//  PhotosRouter.swift
//  vkExtended
//
//  Created Ярослав Стрельников on 15.11.2020.
//  Copyright © 2020 ExtendedTeam. All rights reserved.
//
import UIKit

class PhotosConfigurator {
    static func initModule(_ viewController: PhotosViewController) {
        // Change to get view from storyboard if not using progammatic UI
        let interactor = PhotosInteractor()
        let router = PhotosRouter()
        let presenter = PhotosPresenter(interface: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.interactor = interactor
        router.baseViewController = viewController
    }
}
