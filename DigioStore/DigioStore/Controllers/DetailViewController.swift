//
//  DetailViewController.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!

    private var productData: DigioStoreProduct?

    private var enableBackButton = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = productData {
            titleLabel.text = data.pName
            descriptionLabel.text = data.pDescription
            imageView?.image = UIImage(named: "imageNotFound")
            NetworkHelper.downloadImage(from: URL.init(string: data.pImageURL)!, completion: { data in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView?.image = UIImage(data: data)
                    }
                }
            })
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if self.enableBackButton {
                self.enableBackButton = false
                self.dismiss(animated: true, completion: {
                    self.enableBackButton = true
                })
            }
        }
    }

    public func setProductData(_ data: DigioStoreProduct) {
        productData = data
    }

}
