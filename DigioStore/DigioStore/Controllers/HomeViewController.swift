//
//  ViewController.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    var products = [Product]()
    var spotlights = [Spotlight]()
    var cash = Cash.init()

    private var productData: DigioStoreProduct?

    @IBOutlet weak var spotlightCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!

    @IBOutlet weak var cashImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        callProductsFromServer()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController // swiftlint:disable:this force_cast
        destination.fillData(with: productData!)
    }

    @IBAction func cashButtonPressed(_ sender: Any) {
        self.productData = cash
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

    private func callProductsFromServer() {
        //swiftlint:disable:next force_cast
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        DigioApi.getProducts(completion: { response, error in
            if error != nil {
                print("error")
            } else {
                let productsJson = response["products"] as! [[String: Any]] //swiftlint:disable:this force_cast
                let spotlightsJson = response["spotlight"]  as! [[String: Any]]//swiftlint:disable:this force_cast
                let cashJson = response["cash"]  as! [String: Any]//swiftlint:disable:this force_cast

                do {
                    for product in productsJson {
                        self.products.append(try Product(context: context, dictionary: product))
                    }

                    for spotlight in spotlightsJson {
                        self.spotlights.append(try Spotlight(context: context, dictionary: spotlight))
                    }

                    self.cash = try Cash(context: context, dictionary: cashJson)
                    DispatchQueue.main.async {
                        self.cashImageView?.image = UIImage(named: "imageNotFound")
                    }
                    NetworkHelper.downloadImage(from: URL.init(string: self.cash.pImageURL)!, completion: { data in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.cashImageView.image = UIImage(data: data)
                            }
                        }
                    })

                } catch {
                    print("Error creating the data")
                }

                DispatchQueue.main.async {
                    self.spotlightCollectionView.reloadData()
                    self.productsCollectionView.reloadData()
                }

                print(response)
            }
        })
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == spotlightCollectionView ? spotlights.count : products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = SectionCollectionViewCell()
        var imageString = ""
        if collectionView == spotlightCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotlightSectionCell",
                   for: indexPath) as! SectionCollectionViewCell//swiftlint:disable:this force_cast
            imageString = spotlights[indexPath.row].bannerURL ?? ""

        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productSectionCell",
                   for: indexPath) as! SectionCollectionViewCell//swiftlint:disable:this force_cast
            imageString = products[indexPath.row].imageURL ?? ""
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
        self.productData = collectionView == spotlightCollectionView
        ? spotlights[indexPath.row] : products[indexPath.row]
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

}
