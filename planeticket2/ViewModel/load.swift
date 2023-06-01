//
//  load.swift
//  planeticket2
//
//  Created by DoanThinh on 5/10/23.
//

import Foundation
import Combine
import FirebaseFirestore
class load: ObservableObject{
    @Published var Maybay: maybay
    @Published var modified: false
    private var cancellables = Set<AnyCancellable>()
    init(Maybay: maybay = maybay (theloai:"")){
        self.Maybay = Maybay
        self.$Maybay
            .dropFirst()
            .sink{
                [weak self ] Maybay in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    private var db = Firestore.firestore()
    private func addmaybay(_ Maybay: maybay ){
        do{
            let _ =try db.collection("maybaylist").addDocument(from: Maybay)
        }
        catch{
            print(error)
        }
    }
}
