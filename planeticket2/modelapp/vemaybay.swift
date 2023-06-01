//
//  vemaybay.swift
//  planeticket2
//
//  Created by Thu Thão on 26/05/2023.
//

import Foundation
struct vemaybay{
    let id : String
    let giave: Float
    let iddiadiemdi: Int
    let iddiadiemden: Int
    let idUser:Int
    let idvemaybay:Int
    let ngaydi: Calendar
    let ngayin : Calendar
    let thoigianden: Calendar
    init(id: String = "", giave: Float = 0, iddiadiemdi: Int = 0, iddiadiemden: Int = 0, idUser: Int = 0, idvemaybay: Int = 0, ngaydi: Calendar = Calendar.current, ngayin: Calendar = Calendar.current, thoigianden: Calendar = Calendar.current) {
        self.id = id
        self.giave = giave
        self.iddiadiemdi = iddiadiemdi
        self.iddiadiemden = iddiadiemden
        self.idUser = idUser
        self.idvemaybay = idvemaybay
        self.ngaydi = ngaydi
        self.ngayin = ngayin
        self.thoigianden = thoigianden
    }
    
}
