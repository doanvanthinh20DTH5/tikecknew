import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class File: ObservableObject{
    var ref = Database.database().reference()
    @Published
    var value: String? = nil
    
    func readValue(){
      
        ref.child("KeyA").observeSingleEvent(of: .value){
            snapshot in
            self.value = snapshot.value as? String
        }
    }
}
