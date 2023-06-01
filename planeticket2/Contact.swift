//
//  Contact.swift
//  planeticket2
//
//  Created by DoanThinh on 5/17/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import MessageUI

struct Contact: View {
    @State private var isShowingMailView = false
    @State private var isShowingEmailAlert = false

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
                  if MFMailComposeViewController.canSendMail() {
                                    isShowingMailView = true
                                } else {
                                    isShowingEmailAlert = true
                                }
              }) {
                  Text("Gửi")
                      .foregroundColor(.white)
              }
              .sheet(isPresented: $isShowingMailView) {
                  MaailView(isShowing: $isShowingMailView)
                      }
              .alert(isPresented: $isShowingEmailAlert) {
                             Alert(
                                 title: Text("No Email Account"),
                                 message: Text("There is no email account set up on your device."),
                                 dismissButton: .default(Text("OK"))
                             )
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

struct MaailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = context.coordinator
        mailComposeVC.setToRecipients(["dthuytech@gmail.com"])
        mailComposeVC.setSubject("My Subject")
        mailComposeVC.setMessageBody("Hello, this is the email body.", isHTML: false)
        return mailComposeVC
    }
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
            // No need to update the view controller
        }
        
        class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
            @Binding var isShowing: Bool
            init(isShowing: Binding<Bool>) {
                        _isShowing = isShowing
                    }
                    
                    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                        isShowing = false
                    }
                }
            }
