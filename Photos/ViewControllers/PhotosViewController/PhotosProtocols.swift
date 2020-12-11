//
//  PhotosProtocols.swift
//  vkExtended
//
//  Created Ярослав Стрельников on 15.11.2020.
//  Copyright © 2020 ExtendedTeam. All rights reserved.
//
import Foundation
import UIKit

//MARK: Wireframe -
protocol PhotosWireframeProtocol: class {

}
//MARK: Presenter -
protocol PhotosPresenterProtocol: class {
    func onGetPhotos()
    func onEvent(message: String)
}

//MARK: Interactor -
protocol PhotosInteractorProtocol: class {
    var presenter: PhotosPresenterProtocol?  { get set }
    func getPhotos()
}

//MARK: View -
protocol PhotosViewProtocol: class {
    var presenter: PhotosPresenterProtocol?  { get set }
    func event(message: String, isNeedPopViewController: Bool)
}
