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
        getData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
