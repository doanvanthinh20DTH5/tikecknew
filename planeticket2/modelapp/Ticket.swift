//
//  Ticket.swift
//  planeticket2
//
//  Created by DoanThinh on 5/13/23.
//

import Foundation
struct Vemaybay{
    let id = UUID()
    let giave: Float
    let iddiadiemdi: Int
    let iddiadiemden: Int
    let idUser:Int
    let idvemaybay:Int
    let ngaydi: Date
    let ngayin : Date
    let thoigianden: Date
    enum CodingKeys: CodingKey {
        case id
        case giave
        case iddiadiemdi
        case iddiadiemden
        case idUser
        case idvemaybay
        case ngaydi
        case ngayin
        case thoigianden
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.giave = try container.decode(Float.self, forKey: .giave)
        self.iddiadiemdi = try container.decode(Int.self, forKey: .iddiadiemdi)
        self.iddiadiemden = try container.decode(Int.self, forKey: .iddiadiemden)
        self.idUser = try container.decode(Int.self, forKey: .idUser)
        self.idvemaybay = try container.decode(Int.self, forKey: .idvemaybay)
        self.ngaydi = try container.decode(Date.self, forKey: .ngaydi)
        self.ngayin = try container.decode(Date.self, forKey: .ngayin)
        self.thoigianden = try container.decode(Date.self, forKey: .thoigianden)
    }
    init(idvemaybay: Int, iddiadiemdi:Int,iddiadiemden:Int,idUser : Int,ngaydi:Date,thoigianden:Date,ngayin:Date,giave:Float ) {
    
        self.ngaydi = ngaydi
        self.ngayin = ngayin
        self.thoigianden = thoigianden
        self.idvemaybay = idvemaybay
        self.iddiadiemdi = iddiadiemdi
        self.iddiadiemden = iddiadiemden
        self.idUser = idUser
        self.giave = giave
    }
   
}
