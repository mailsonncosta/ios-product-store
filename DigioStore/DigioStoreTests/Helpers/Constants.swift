//
//  Constants.swift
//  DigioStoreTests
//
//  Created by Mailson Costa on 25/09/21.
//

import Foundation

enum ProductNames {
    static let name1 = "product-01"
    static let name2 = "product-02"
    static let name3 = "product-03"
    static let name4 = "product-04"
}

enum ProductDescriptions {
    static let description1 = "description-01-card"
    static let description2 = "description-02-ticket"
    static let description3 = "description-03-transfer"
    static let description4 = "description-04-card"
}

enum ProductURLs {
    static let url1 = "http://url-01-card"
    static let url2 = "http://url-02-ticket"
    static let url3 = "http://url-03-transfer"
    static let url4 = "http://url-04-card"
}

enum ProductsSample {
    static let product01 = [
        "name": ProductNames.name1,
        "description": ProductDescriptions.description1,
        "imageURL": ProductURLs.url1]
    static let product02 = [
        "name": ProductNames.name2,
        "description": ProductDescriptions.description2,
        "imageURL": ProductURLs.url2]
    static let product03 = [
        "name": ProductNames.name3,
        "description": ProductDescriptions.description3,
        "imageURL": ProductURLs.url3]
    static let product04 = [
        "name": ProductNames.name4,
        "description": ProductDescriptions.description4,
        "imageURL": ProductURLs.url1]
}

enum SpotlightsSample {
    static let spotlight01 = [
        "name": ProductNames.name1,
        "description": ProductDescriptions.description1,
        "bannerURL": ProductURLs.url1]
    static let spotlight02 = [
        "name": ProductNames.name2,
        "description": ProductDescriptions.description2,
        "bannerURL": ProductURLs.url2]
    static let spotlight03 = [
        "name": ProductNames.name3,
        "description": ProductDescriptions.description3,
        "bannerURL": ProductURLs.url3]
    static let spotlight04 = [
        "name": ProductNames.name4,
        "description": ProductDescriptions.description4,
        "bannerURL": ProductURLs.url1]
}

enum CashSample {
    static let cash01 = [
        "title": ProductNames.name1,
        "description": ProductDescriptions.description1,
        "bannerURL": ProductURLs.url1]
    static let cash02 = [
        "title": ProductNames.name2,
        "description": ProductDescriptions.description2,
        "bannerURL": ProductURLs.url2]
}
