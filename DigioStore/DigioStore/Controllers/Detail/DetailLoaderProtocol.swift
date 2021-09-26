//
//  DetailLoaderProtocol.swift
//  DigioStore
//
//  Created by Mailson Costa on 26/09/21.
//

import Foundation

protocol DetailViewProtocol {
    func imageSucessfulLoaded(_ imageData: Data)
    func fillViewData(title: String, description: String)
}

final class DetailLoader {
    static var current: DetailLoader = DetailLoader()
    static var delegate: DetailViewProtocol?
}
