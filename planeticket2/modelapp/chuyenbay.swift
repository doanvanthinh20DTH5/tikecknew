//
//  chuyenbay.swift
//  planeticket2
//
//  Created by Thu Thão on 25/05/2023.
//

import Foundation
struct chuyenbay{
   
    var idchuyenbay:Int
    var idiadiemdi:Int
    var idiadiemden:Int
    var idmaybay:Int
    var thoigianden: Calendar
    var thoigiandi:Calendar
    
    init(idchuyenbay: Int, idiadiemdi: Int, idiadiemden: Int, idmaybay: Int, thoigianden: Calendar, thoigiandi: Calendar) {
        self.idchuyenbay = idchuyenbay
        self.idiadiemdi = idiadiemdi
        self.idiadiemden = idiadiemden
        self.idmaybay = idmaybay
        self.thoigianden = thoigianden
        self.thoigiandi = thoigiandi
    }
        
    
}
