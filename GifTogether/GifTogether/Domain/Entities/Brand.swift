//
//  Brand.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/23.
//

import Foundation

enum Brand: String, CaseIterable {

    case bbq
    case bhc
    case kyochon
    case gs
    case cu
    case starbucks
    case twosomeplace
    case ediyaCoffee
    case hollysCoffee
    case tomNToms
    case parisbaguette
    case touslesjours
    case dunkinDonut
    case lotteria
    case bergerKing
    case pizzaHut
    case shinsegeaShopping
    case lotteShopping
    case hyundaiShopping
    
    var name: String {
        switch self {
        case .bbq:
            return "비비큐"
        case .bhc:
            return "BHC"
        case.kyochon:
            return "교촌치킨"
        case .gs:
            return "GS편의점"
        case .cu:
            return "CU편의점"
        case .starbucks:
            return "스타벅스"
        case .twosomeplace:
            return "투썸플레이스"
        case .ediyaCoffee:
            return "이디야커피"
        case.hollysCoffee:
            return "할리스커피"
        case .tomNToms:
            return "탐앤탐스"
        case .parisbaguette:
            return "파리바게트"
        case .touslesjours:
            return "뚜레쥬르"
        case .dunkinDonut:
            return "던킨도넛"
        case .lotteria:
            return "롯데리아"
        case .bergerKing:
            return "버거킹"
        case .pizzaHut:
            return "피자헛"
        case .shinsegeaShopping:
            return "신세계 백화점"
        case .lotteShopping:
            return "롯데 백화점"
        case .hyundaiShopping:
            return "현대 백화점"
        }
    }
    var imageName: String {
        switch self {
        case .bbq:
            return "bbq"
        case .bhc:
            return "bhc"
        case.kyochon:
            return "kyochon"
        case .gs:
            return "gs"
        case .cu:
            return "cu"
        case .starbucks:
            return "starbucks"
        case .twosomeplace:
            return "twosomeplace"
        case .ediyaCoffee:
            return "ediya"
        case.hollysCoffee:
            return "hollys"
        case .tomNToms:
            return "tomNToms"
        case .parisbaguette:
            return "parisbaguette"
        case .touslesjours:
            return "touslesjours"
        case .dunkinDonut:
            return "dunkin"
        case .lotteria:
            return "lotteria"
        case .bergerKing:
            return "bergerking"
        case .pizzaHut:
            return "pizzahut"
        case .shinsegeaShopping:
            return "shinsegae"
        case .lotteShopping:
            return "lotte"
        case .hyundaiShopping:
            return "hyundai"
        }
    }
}
