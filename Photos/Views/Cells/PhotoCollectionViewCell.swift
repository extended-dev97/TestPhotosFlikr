//
//  PhotoCollectionViewCell.swift
//  Photos
//
//  Created by Ярослав Стрельников on 10.12.2020.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var image: UIImage? {
        get { return photoImageView.image }
        set { photoImageView.image = newValue }
    }
}
