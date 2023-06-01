//
//  addData.swift
//  planeticket2
//
//  Created by DoanThinh on 5/18/23.
//

import SwiftUI
import FirebaseFirestore

let db = Firestore.firestore()


struct addData: View {
    var body: some View {
        
        Button(action: {
            addSeatData()}) {
                Text("Add")        }
        
        
    }
    func addSeatData() {
        for row in ["A", "B", "C", "D", "E", "F"] {
            for number in 10...30 {
                let seatNumber = "\(row)\(number)"
                let isBooked = true
                let idchuyenbay = 1// Có thể thay đổi giá trị tùy theo yêu cầu
                
                let data: [String: Any] = [
                    "seatNumber": seatNumber,
                    "isBooked": isBooked,
                    "idchuyenbay": idchuyenbay
                ]
                
                db.collection("seats").document(seatNumber).setData(data) { error in
                    if let error = error {
                        print("Error adding seat data: \(error)")
                    } else {
                        print("Seat data added successfully")
                    }
                }
            }
            
        }}
}

struct addData_Previews: PreviewProvider {
    static var previews: some View {
        addData()
    }
}
