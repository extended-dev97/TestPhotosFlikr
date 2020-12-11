//
//  BaseViewController.swift
//  Photos
//
//  Created by Ярослав Стрельников on 11.12.2020.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        NotificationCenter.default.addObserver(self, selector: #selector(onNetworkStateChanged), name: .networkStateChanged, object: nil)
    }
    
    // Событие (сообщение)
    func event(message: String, isNeedPopViewController: Bool = false) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: { [weak self] in
                guard isNeedPopViewController, let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            })
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // Изменилось состояние сети
    @objc func onNetworkStateChanged(_ notification: Notification) { }
}
