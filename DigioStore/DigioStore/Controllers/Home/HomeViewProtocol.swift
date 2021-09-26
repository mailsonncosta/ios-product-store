//
//  HomeViewProtocol.swift
//  DigioStore
//
//  Created by Mailson Costa on 26/09/21.
//

import Foundation

protocol HomeViewProtocol {
    func cashImageSucessfulLoaded(_ imageData: Data)
    func updateCollectionData()
}

final class HomeLoader {
    static var current: HomeLoader = HomeLoader()
    static var delegate: HomeViewProtocol?
}
