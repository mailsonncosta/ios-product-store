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

    private var enableBackButton = true
    private var productData: DigioStoreProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        initDetailViewProtocol()
        _ = DetailViewModel.init(productData!)
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

    public func fillData(with object: DigioStoreProduct) {
        productData = object
    }

}

extension DetailViewController: DetailViewProtocol {

    func initDetailViewProtocol() {
        DetailLoader.delegate = self
    }

    func imageSucessfulLoaded(_ imageData: Data) {
        DispatchQueue.main.async {
            self.imageView?.image = UIImage(data: imageData)
        }
    }

    func fillViewData(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }

}
