//
//  Contact.swift
//  planeticket2
//
//  Created by DoanThinh on 5/17/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Contact: View {
    @State private var name = ""
      @State private var email = ""
      @State private var message = ""
      
      var body: some View {
          VStack {
              Text("Liên hệ")
                  .font(.title)
                  .padding()
              
              TextField("Tên", text: $name)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
              
              TextField("Email", text: $email)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
              ZStack {
                  TextEditor(text: $message)
                      .frame(height: 200)
                      .padding()
              }
              
              Button(action: {
                  sendEmail()
                  saveToFirestore()
              }) {
                  Text("Gửi")
                      .foregroundColor(.white)
              }
              .padding()
              .background(Color.blue)
              .cornerRadius(10)
          }
          .padding()
      }
      
      func sendEmail() {
          // Gửi email đến admin
          // Sử dụng MFMailComposeViewController hoặc giao diện khác để tạo email
      }
      
      func saveToFirestore() {
          let db = Firestore.firestore()
          
          let contactInfo: [String: Any] = [
              "name": name,
              "email": email,
              "message": message
          ]
          
          db.collection("contacts").addDocument(data: contactInfo) { error in
              if let error = error {
                  print("Lỗi: \(error.localizedDescription)")
              } else {
                  print("Lưu thông tin liên hệ thành công")
              }
          }
      }
}

struct Contact_Previews: PreviewProvider {
    static var previews: some View {
        Contact()
    }
}
