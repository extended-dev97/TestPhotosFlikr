//
//  PhotosViewController.swift
//
//  Created Ярослав Стрельников on 15.11.2020.
//  Copyright © 2020 ExtendedTeam. All rights reserved.
//
import UIKit
import RealmSwift
import Kingfisher

class PhotosViewController: BaseViewController, PhotosViewProtocol {
    @IBOutlet weak var photosCollectionView: UICollectionView!

    private var photos = try! Realm().objects(PhotoObject.self)
    private var token: NotificationToken?

    fileprivate var selectedCell: PhotoCollectionViewCell?

    internal var presenter: PhotosPresenterProtocol?
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        PhotosConfigurator.initModule(self)
        presenter?.onGetPhotos()
        observePhotos()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        photosCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Отслеживание изменений БД
    func observePhotos() {
        photos.safeObserve({ [weak self] changes in
            guard let self = self else { return }
            
            switch changes {
            case .initial:
                self.photosCollectionView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                self.photosCollectionView.applyChanges(with: deletions, with: insertions, with: updates)
            case .error(let error):
                print(error.localizedDescription)
            }
        }) { [weak self] (token) in
            guard let self = self else { return }
            self.token = token
        }
    }
    
    // Конфигурация коллекции
    func configureCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    
    // Изменилось состояние сети
    @objc override func onNetworkStateChanged(_ notification: Notification) {
        super.onNetworkStateChanged(notification)
        switch Network.reachability.status {
        case .unreachable:
            title = "Photos (Offline mode)"
        case .wwan, .wifi:
            title = "Photos"
        }
    }

    // Обновить фотографии
    @IBAction func onRefreshPhotos(_ sender: UIBarButtonItem) {
        presenter?.onGetPhotos()
    }
}
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.kf.setImage(with: photos[indexPath.item].previewURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell

        let vc = PreviewPhotoViewController(url: photos[indexPath.item].fullSizeURL)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension PhotosViewController: UICollectionViewDelegateFlexLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        let padding = UIScreen.main.bounds.width.getPercent(!(UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? true) ? 10 : 4)
        return .custom(0, padding, padding, 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, horizontalSpacingBetweenSectionAt section: Int, and nextSection: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenSectionAt section: Int, and nextSection: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .identity(collectionView.bounds.width.getPercent(!(UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? true) ? 35 : 20))
    }
}
