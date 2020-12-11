//
//  PhotosPresenter.swift
//  vkExtended
//
//  Created Ярослав Стрельников on 15.11.2020.
//  Copyright © 2020 ExtendedTeam. All rights reserved.
//
import UIKit

class PhotosPresenter: PhotosPresenterProtocol {

    weak private var view: PhotosViewProtocol?
    var interactor: PhotosInteractorProtocol?
    private let router: PhotosWireframeProtocol

    init(interface: PhotosViewProtocol, interactor: PhotosInteractorProtocol?, router: PhotosWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // Загрузить фотки
    func onGetPhotos() {
        interactor?.getPhotos()
    }
    
    // Уведомление о событии
    func onEvent(message: String) {
        DispatchQueue.main.async {
            self.view?.event(message: message, isNeedPopViewController: false)
        }
    }
}
