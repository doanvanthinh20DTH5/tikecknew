//
//  detailtciket.swift
//  planeticket2
//
//  Created by DoanThinh on 5/13/23.
//

import SwiftUI
import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import AssetsLibrary




struct detailtciket: View {
    struct Vemaybayy: Identifiable, Decodable, Hashable {
        let id = UUID()
        let giave: Int
        let iddiemden: Int
        let iddiemdi: Int
        let iduser: Int
        let idvemaybay: Int
        let ngaydi: Date
        let ngayin : Date
        let thoigiandukienden: Date
        
    }
        
        let vemaybay = Vemaybay(idvemaybay: 1, iddiadiemdi: 1, iddiadiemden: 2, idUser: 1, ngaydi: Date.now, thoigianden: Date.now, ngayin: Date.now,giave: 700.000)
        struct Cardviewuser: View{
            var username = "Doan van thinh"
            var sdt = "09066262612"
            var body:some View{
                VStack(alignment:.leading,spacing: 0){
                    VStack(alignment: .leading, spacing: 0){
                        HStack(spacing: 0){
                            Image("backgroundticket")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .padding(.leading, 10)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            Text(username)
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        
                        HStack{
                            
                            Text(sdt)
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        .padding(.top, -20)
                    }
                    .frame(width:350, height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    
                }
                
            }
        }
    
    //struct tét db
        struct CardView: View{
            var vemabaynew = Vemaybay(idvemaybay: 1, iddiadiemdi: 1, iddiadiemden: 2, idUser: 1, ngaydi: Date.now, thoigianden: Date.now, ngayin: Date.now,giave: 700.000)
            var body: some View{
                VStack (alignment:.leading,spacing: 0){
                    HStack{
                        Text("Vung tau")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()
                        
                        Text("Ha noi")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    
                    HStack{
                        HStack{
                            Text("Gio di: \(vemabaynew.ngaydi)")
                                .font(.system(size: 18))
                            
                                .font(.title)
                                .foregroundColor(.gray)
                                .padding()
                            
                            Spacer()
                            
                        }
                    }
                    .padding(.top, -20)
                    
                }
                .frame(width: 350, height: 190)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            }
            //        func formatdatetime() -> String{
            //            vemabaynew.ngaydi.formatted(date: Date.FormatStyle.DateStyle, time: "h:mm a")
            //        }
        }
        @FirestoreQuery(collectionPath: "vemaybay",
                        predicates: [.order(by: "idvemaybay")]
        ) var veemaybay:[Vemaybayy]
        
        var body: some View {
            
            
            VStack{
                
                CardView()
                
                Cardviewuser()
                Text("\(veemaybay.count)")
                
               
                
                Spacer()
            }
        }
    }

struct detailtciket_Previews: PreviewProvider {
    static var previews: some View {
        detailtciket()
    }
}
