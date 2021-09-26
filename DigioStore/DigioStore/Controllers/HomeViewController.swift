//
//  ViewController.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var spotlightCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!

    @IBOutlet weak var cashImageView: UIImageView!

    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initHomeViewProtocol()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController // swiftlint:disable:this force_cast
        destination.fillData(with: homeViewModel.productData!)
    }

    @IBAction func cashButtonPressed(_ sender: Any) {
        homeViewModel.setSelectedProduct(homeViewModel.cash)
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == spotlightCollectionView
            ? homeViewModel.spotlights.count : homeViewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = SectionCollectionViewCell()
        var imageString = ""
        if collectionView == spotlightCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotlightSectionCell",
                   for: indexPath) as! SectionCollectionViewCell//swiftlint:disable:this force_cast
            imageString = homeViewModel.spotlights[indexPath.row].bannerURL ?? ""

        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productSectionCell",
                   for: indexPath) as! SectionCollectionViewCell//swiftlint:disable:this force_cast
            imageString = homeViewModel.products[indexPath.row].imageURL ?? ""
        }

        cell.imageView?.image = UIImage(named: "imageNotFound")
        NetworkHelper.downloadImage(from: URL.init(string: imageString)!, completion: { data in
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        })

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let digioProduct: DigioStoreProduct = collectionView == spotlightCollectionView
            ? homeViewModel.spotlights[indexPath.row] : homeViewModel.products[indexPath.row]
        homeViewModel.setSelectedProduct(digioProduct)
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

}

extension HomeViewController: HomeViewProtocol {

    func initHomeViewProtocol() {
        HomeLoader.delegate = self
    }

    func cashImageSucessfulLoaded(_ imageData: Data) {
        DispatchQueue.main.async {
            self.cashImageView.image = UIImage(data: imageData)
        }
    }

    func updateCollectionData() {
        DispatchQueue.main.async {
            self.spotlightCollectionView.reloadData()
            self.productsCollectionView.reloadData()
        }
    }

}
