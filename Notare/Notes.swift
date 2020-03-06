//
//  Notes.swift
//  Notare
//
//  Created by Bree Jeune on 3/2/20.
//  Copyright © 2020 Young. All rights reserved.
//

import Foundation

struct Note: Codable, Equatable {
  var name: String
  var category: Category

}

enum Category: CaseIterable, RawRepresentable, Codable {
    
  case all
  case favorites
  case unassigned
    
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
      switch rawValue {
      case "All": self = .all
      case "Favorites": self = .favorites
      case "Unassigned": self = .unassigned
      default: return nil
      }
    }
    
    var rawValue: RawValue {
      switch self {
      case .all: return "All"
      case .favorites: return "Favorites"
      case .unassigned: return "Unassigned"
      }
}

  static func notes() -> [Note] {
    guard
      let url = Bundle.main.url(forResource: "notes", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode([Note].self, from: data)
    } catch {
      return []
    }
    }
}
