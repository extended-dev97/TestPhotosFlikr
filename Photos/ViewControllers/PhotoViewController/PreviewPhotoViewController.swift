//
//  PreviewPhotoViewController.swift
//  Photos
//
//  Created by Ярослав Стрельников on 11.12.2020.
//

import UIKit
import Kingfisher

class PreviewPhotoViewController: BaseViewController {
    @IBOutlet weak var artworkImageView: UIImageView!

    private var url: URL?

    init(url: URL?) {
        self.url = url
        super.init(nibName: "PreviewPhotoViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        guard let url = url else { return }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.artworkImageView.image = value.image
            case .failure(let error):
                self.event(message: error.errorDescription ?? "", isNeedPopViewController: true)
            }
        }
    }
    
    // Изменилось состояние сети
    @objc override func onNetworkStateChanged(_ notification: Notification) {
        super.onNetworkStateChanged(notification)
        switch Network.reachability.status {
        case .unreachable:
            title = "Preview photo (Offline mode)"
        case .wwan, .wifi:
            title = "Preview photo"
        }
    }
}
