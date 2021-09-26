//
//  NetworkHelper.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

import UIKit

class NetworkHelper {
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    static func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        getData(from: url) { data, response, error in
            let httpResponse = response as! HTTPURLResponse // swiftlint:disable:this force_cast
            guard let data = data, httpResponse.statusCode == 200, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
