//
//  loaive1.swift
//  planeticket2
//
//  Created by DoanThinh on 5/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct loaive1: Codable{
    @DocumentID
    var tenloai: String?
    
    enum CodingKeys: String, CodingKey {
        case tenloai
    }
}

