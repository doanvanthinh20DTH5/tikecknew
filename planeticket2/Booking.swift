    //
    //  Booking.swift
    //  planeticket2
    //
    //  Created by DoanThinh on 5/18/23.
    //

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class SeatSelection: ObservableObject {
    @Published var selectedSeat: String?
}

struct Seat: Identifiable, Codable {
    @DocumentID var id: String?
    let seatNumber: String
    var isBooked: Bool
}

class SeatManager: ObservableObject {
    @Published var seats: [Seat] = []
    @Published var lastSelectedSeat: String?
    private var db = Firestore.firestore()
    private var seatsCollection: CollectionReference {
        db.collection("seats")
    }
    
    init() {
        loadBookingStatusFromDatabase()
    }
    
    func bookSeat(_ seat: Seat) {
        if let seatIndex = seats.firstIndex(where: { $0.id == seat.id }) {
            seats[seatIndex].isBooked = true
            lastSelectedSeat = seat.seatNumber // Update the last selected seat
            updateBookingStatusInDatabase(seats[seatIndex])
        }
    }
    
    func cancelSeatBooking(_ seat: Seat) {
        if let seatIndex = seats.firstIndex(where: { $0.id == seat.id }) {
            seats[seatIndex].isBooked = false
            updateBookingStatusInDatabase(seats[seatIndex])
        }
    }
    
    func updateBookingStatusInDatabase(_ seat: Seat) {
        do {
            try seatsCollection.document(seat.id!).setData(from: seat)
        } catch {
            print("Error updating booking status: \(error)")
        }
    }
    
    func loadBookingStatusFromDatabase() {
        seatsCollection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.seats = documents.compactMap { document in
                try? document.data(as: Seat.self)
            }
        }
    }
}
struct SeatSelectionView: View {
    @ObservedObject var seatManager = SeatManager()
     @EnvironmentObject var seatSelection: SeatSelection
     
     var body: some View {
         VStack {
             Text("Chọn chỗ")
                 .font(.title)
             
             // Hiển thị chỗ ngồi đã chọn
             Text("Chỗ ngồi đã chọn: \(seatSelection.selectedSeat ?? "")")
                 .foregroundColor(.blue)
                 .font(.headline)
             
             // Danh sách chỗ ngồi
             ScrollView {
                 LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                     ForEach(seatManager.seats) { seat in
                         Button(action: {
                             seatSelection.selectedSeat = seat.seatNumber
                         }) {
                             Text(seat.seatNumber)
                                 .font(.title)
                                 .padding()
                                 .background(seat.isBooked ? Color.gray : (seatSelection.selectedSeat == seat.seatNumber ? Color.blue : Color.gray))
                                 .foregroundColor(.white)
                                 .cornerRadius(8)
                         }
                     }
                 }
             }
         }
         .padding()
     }
}

struct Luggage {
    let weight: Int // Số kg hành lý
    var price: Int { // Giá tiền (computed property)
           calculatePrice(weight: weight)
       }
    private func calculatePrice(weight: Int) -> Int {
        let baseWeight = 19 // Số kg hành lý miễn phí
        let basePrice = 0 // Giá tiền cho số kg hành lý miễn phí
        let pricePerKg = 100000 // Giá tiền cho mỗi kg hành lý trên số kg hành lý miễn phí
        if weight <= baseWeight {
            return basePrice
        } else {
            let additionalWeight = max(weight - baseWeight, 0)
            let additionalPrice = (additionalWeight + 10) / 10 * pricePerKg
            return basePrice + additionalPrice
        }
    }
}
struct Chitietgia: Decodable, Identifiable{
    var id = UUID()
    let giave: Int
    let iddiadiemden: Int
    let iddiadiemdi: Int
    let idloaive: Int
}
struct Booking: View {
    @StateObject private var seatSelection = SeatSelection()
    @State private var luggageWeight: Int = 0
    @FirestoreQuery(collectionPath: "chitietgia",
                    predicates: [.order(by: "idloaive")]
    ) var ten1:[Chitietgia]
    private var totalPrice: Int {
           let luggage = Luggage(weight: luggageWeight)
           return luggage.price
       }
       
    
    var body: some View {
        VStack {
            Text("\(ten1.count)")
            SeatSelectionView()
                .environmentObject(seatSelection)
            
            Text("Thông tin hành lý")
                           .font(.title)
                       
                       Stepper(" \(luggageWeight) kg hành lý mang theo", value: $luggageWeight, in: 0...70)
                        
                       
                       Text("giá tiền hành lý: \(totalPrice) VND")
                           .font(.headline)
                           .padding()
            Button(action: {
                            // Xử lý khi bấm nút đặt vé
                            print("Đặt vé")
                        }) {
                            Text("Đặt vé")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
        }
        .padding()
    }
}

struct Booking_Previews: PreviewProvider {
    static var previews: some View {
        Booking()
    }
}
