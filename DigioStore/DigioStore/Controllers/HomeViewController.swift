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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController // swiftlint:disable:this force_cast
        destination.setProductData(productData!)
    }

    @IBAction func action(_ sender: Any) {
        //swiftlint:disable:next force_cast
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        productData = try! Cash(context: context, dictionary: [ // swiftlint:disable:this force_try
                                    "title": "Cash",
                                    "description": "Desciption",
                                    "bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png"])
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }

}
