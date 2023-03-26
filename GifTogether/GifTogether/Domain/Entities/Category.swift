//
//  Category.swift
//  GifTogether
//
//  Created by 이은찬, 이원빈 on 2023/03/12.
//

import Foundation

enum Category: String, CaseIterable {
    
    case cafeDissert
    case mart
    case chicken
    case bakery
    case fastFood
    case giftCard
    
    var brand: [Brand] {
        switch self {
        case .cafeDissert:
            return [.tomNToms, .twosomeplace, .hollysCoffee, .starbucks, .ediyaCoffee]
        case .mart:
            return [.gs, .cu]
        case .chicken:
            return [.bhc, .bbq, .kyochon]
        case .bakery:
            return [.parisbaguette, .touslesjours, .dunkinDonut]
        case .fastFood:
            return [.lotteria, .bergerKing, .pizzaHut]
        case .giftCard:
            return [.shinsegeaShopping, .lotteShopping, .hyundaiShopping]
        }
    }
    
    var imageName: String {
        switch self {
        case .cafeDissert:
            return "dessert"
        case .mart:
            return "convenience"
        case .chicken:
            return "chicken"
        case .bakery:
            return "bakery"
        case .fastFood:
            return "fastfood"
        case .giftCard:
            return "giftcard"
        }
    }
    
    var layout: (xPosition: CGFloat, width: CGFloat) {
        switch self {
        case .cafeDissert:
            return (CGFloat(-195), CGFloat(110))
        case .mart:
            return (CGFloat(-95), CGFloat(100))
        case .chicken:
            return (CGFloat(-15), CGFloat(50))
        case .bakery:
            return (CGFloat(50), CGFloat(80))
        case .fastFood:
            return (CGFloat(135), CGFloat(90))
        case .giftCard:
            return (CGFloat(215), CGFloat(60))
        }
    }
    
    var title: String {
        switch self {
        case .cafeDissert:
            return "카페• 디저트"
        case .mart:
            return "편의점•마트"
        case .chicken:
            return "치킨"
        case .bakery:
            return "베이커리"
        case .fastFood:
            return "패스트푸드"
        case .giftCard:
            return "상품권"
        }
    }
}
