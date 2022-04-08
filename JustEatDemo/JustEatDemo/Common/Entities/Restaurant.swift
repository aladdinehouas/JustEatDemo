//
//  Restaurant.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 29/3/2022.
//

import Foundation

enum OpenStatus: String, Codable, Comparable{
    case open = "open"
    case orderAhead = "order ahead"
    case closed = "closed"
    
    private var sortOrder: Int {
           switch self {
               case .open:
                   return 0
               case .orderAhead:
                   return 1
               case .closed:
                   return 2
           }
       }
    
    static func < (lhs: OpenStatus, rhs: OpenStatus) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}

struct Restaurant: Codable{
    let name : String?
    let status : OpenStatus?
    let sortingValues : SortingValues?
    
    enum CodingKeys: String, CodingKey {
        case name, status, sortingValues
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        if let openStatus = try values.decodeIfPresent(String.self, forKey: .status) {
            status = OpenStatus(rawValue: openStatus)
        } else {
            status = .closed
        }
        sortingValues = try values.decodeIfPresent(SortingValues.self, forKey: .sortingValues)
    }
    
    init(withName name: String, status: OpenStatus, sortingValues: SortingValues){
        self.name = name
        self.status = status
        self.sortingValues = sortingValues
    }
}

