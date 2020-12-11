//
//  UICollectionView+Extension.swift
//  Photos
//
//  Created by Ярослав Стрельников on 11.12.2020.
//

import Foundation
import UIKit

extension UICollectionView {
    func applyChanges(with deletions: [Int], with insertions: [Int], with updates: [Int]) {
        performBatchUpdates {
            deleteItems(at: deletions.map { IndexPath(item: $0, section: 0) })
            insertItems(at: insertions.map { IndexPath(item: $0, section: 0) })
            reloadItems(at: updates.map { IndexPath(item: $0, section: 0) })
        }
    }
}
