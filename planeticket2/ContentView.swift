//
//  ContentView.swift
//  planeticket2
//
//  Created by DoanThinh on 5/9/23.
//
import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import AssetsLibrary


struct Flight1: Identifiable, Decodable, Hashable{
    let id = UUID()
    let idchuyenbay: Int
    let iddiadiemden: Int
    let iddiadiemdi: Int
    let idmaybay: Int
    let thoigianden: Date
    let thoigiandi: Date
    enum CodingKeys: String, CodingKey {
            case id
            case idchuyenbay
            case iddiadiemden
            case iddiadiemdi
            case idmaybay
            case thoigianden
            case thoigiandi
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
                    idchuyenbay = try container.decode(Int.self, forKey: .idchuyenbay)
                    iddiadiemden = try container.decode(Int.self, forKey: .iddiadiemden)
                    iddiadiemdi = try container.decode(Int.self, forKey: .iddiadiemdi)
                    idmaybay = try container.decode(Int.self, forKey: .idmaybay)
                    
                    let timestampDen = try container.decodeIfPresent(Timestamp.self, forKey: .thoigianden)
                    if let timestampDen = timestampDen {
                        thoigianden = timestampDen.dateValue()
                    } else {
                        thoigianden = Date()
                    }
                    
                    let timestampDi = try container.decodeIfPresent(Timestamp.self, forKey: .thoigiandi)
                    if let timestampDi = timestampDi {
                        thoigiandi = timestampDi.dateValue()
                    } else {
                        thoigiandi = Date()
                    }
        }
}
struct ContentView: View {
    
    @FirestoreQuery(collectionPath: "chuyenbay",
                    predicates: [.order(by: "idchuyenbay")]
    ) var flighttest:[Flight1]
    var body: some View {
        Text("\(flighttest.count)")
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
