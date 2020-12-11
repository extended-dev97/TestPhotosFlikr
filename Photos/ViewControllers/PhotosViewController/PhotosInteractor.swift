//
//  PhotosInteractor.swift
//  vkExtended
//
//  Created Ярослав Стрельников on 15.11.2020.
//  Copyright © 2020 ExtendedTeam. All rights reserved.
//
import UIKit
import RealmSwift

class PhotosInteractor: PhotosInteractorProtocol {

    weak var presenter: PhotosPresenterProtocol?
    
    func getPhotos() {
        Api.getRecentPhotos().done { [weak self] photos in
            guard let self = self else { return }
            do {
                let realm = try Realm()
                try realm.safeWrite {
                    realm.deleteAll()
                }
                try realm.safeWrite {
                    realm.add(photos.photo.map { PhotoObject(photo: $0) })
                }
            } catch {
                self.presenter?.onEvent(message: error.toFlikr().toApi()?.message ?? error.localizedDescription)
            }
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.presenter?.onEvent(message: error.localizedDescription)
        }
    }
}
