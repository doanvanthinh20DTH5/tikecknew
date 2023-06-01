    //
    //  viewFindPlane.swift
    //  planeticket2
    //
    //  Created by DoanThinh on 5/10/23.
    //

    import SwiftUI
    import FirebaseFirestore
    import FirebaseFirestoreSwift
    import AssetsLibrary
    import Foundation



    struct DiaDiem: Identifiable, Decodable, Hashable{
        let id = UUID()
        let tendiadiem: String
        let iddiadiem: Int
        
    }
    struct Flight: Identifiable, Decodable, Hashable{
        let id = UUID()
        let idchuyenbay: Int
        let iddiadiemden: Int
        let iddiadiemdi: Int
        let idmaybay: Int
        let thoigianden: Date
        let thoigiandi: Date
        enum CodingKeys: String, CodingKey {
                case id
                case idchuyenbay
                case iddiadiemden
                case iddiadiemdi
                case idmaybay
                case thoigianden
                case thoigiandi
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                        idchuyenbay = try container.decode(Int.self, forKey: .idchuyenbay)
                        iddiadiemden = try container.decode(Int.self, forKey: .iddiadiemden)
                        iddiadiemdi = try container.decode(Int.self, forKey: .iddiadiemdi)
                        idmaybay = try container.decode(Int.self, forKey: .idmaybay)
                        
                        let timestampDen = try container.decodeIfPresent(Timestamp.self, forKey: .thoigianden)
                        if let timestampDen = timestampDen {
                            thoigianden = timestampDen.dateValue()
                        } else {
                            thoigianden = Date()
                        }
                        
                        let timestampDi = try container.decodeIfPresent(Timestamp.self, forKey: .thoigiandi)
                        if let timestampDi = timestampDi {
                            thoigiandi = timestampDi.dateValue()
                        } else {
                            thoigiandi = Date()
                        }
            }
        
    }

    struct viewFindPlane: View {
        
        @FirestoreQuery(collectionPath: "diadiem",
                        predicates: [.order(by: "tendiadiem")]
        ) var diadiem:[DiaDiem]
        
        
        @FirestoreQuery(collectionPath: "chuyenbay",
                        predicates: [.order(by: "idchuyenbay")]
        ) var flighttest:[Flight]
        @State private var isDatePickerShown = false
           @State private var selectedDate = Date()
        @State var selectedDiaDiem1: DiaDiem? = nil
        @State var selectedDiaDiem2: DiaDiem? = nil
        @State var flights: [Flight] = []
        var body: some View {
            NavigationView {
            VStack {
                
                Text("\(diadiem.count)")
                Text("\(flighttest.count)")
                Picker("Chọn địa điểm đi", selection: $selectedDiaDiem1) {
                    Text("Chọn địa điểm đi")
                        .tag(nil as DiaDiem?)
                    ForEach(diadiem) { diaDiem in
                        Text(diaDiem.tendiadiem)
                            .tag(diaDiem as DiaDiem?)
                    }
                }
                .onChange(of: selectedDiaDiem1) { newValue in
                    if newValue == nil {
                        selectedDiaDiem1 = diadiem.first
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .overlay(
                    Text(selectedDiaDiem1?.tendiadiem ?? "")
                        .foregroundColor(.gray)
                        .padding(.leading, 8),
                    alignment: .leading
                )
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                
                Text("\(flighttest.count)")
                Picker("Chọn địa điểm đến", selection: $selectedDiaDiem2) {
                    Text("Chọn địa điểm đến")
                        .tag(nil as DiaDiem?)
                    ForEach(diadiem) { diaDiem in
                        Text(diaDiem.tendiadiem)
                            .tag(diaDiem as DiaDiem?)
                    }
                }
                .onChange(of: selectedDiaDiem2) { newValue in
                    if newValue == nil {
                        selectedDiaDiem2 = diadiem.first
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .overlay(
                    Text(selectedDiaDiem2?.tendiadiem ?? "")
                        .foregroundColor(.gray)
                        .padding(.leading, 8),
                    alignment: .leading
                )
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .shadow(color: .gray, radius: 2, x: 0.0, y: 0.0)
                TextField("Chọn ngày đi", value: $selectedDate, formatter: dateFormatter, onEditingChanged: { isEditing in
                    if isEditing {
                        isDatePickerShown = true
                    }
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if isDatePickerShown {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .onChange(of: selectedDate) { _ in
                            isDatePickerShown = false
                        }
                }
                
                Button(action: {
                    self.findFlights()
                }
                       
                ){
                    Text("Tìm Kiếm")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.orange)
                        .cornerRadius(5)
                        .frame(maxWidth: .infinity)
                }
                
                
                    List(flights) { flight in
                        NavigationLink(destination: fillInformation()) {
                            VStack(alignment: .leading) {
                                if let departure = diadiem.first(where: { $0.iddiadiem == flight.iddiadiemdi }),
                                   let destination = diadiem.first(where: { $0.iddiadiem == flight.iddiadiemden }) {
                                    Text("Ngày đi: \(flight.thoigiandi.description)")
                                    Text("Ngày đến: \(flight.thoigianden.description)")
                                    Text("Địa điểm đi: \(departure.tendiadiem)")
                                    Text("Địa điểm đến: \(destination.tendiadiem)")
                                }
                            }
                        }
                    }
                }
                 
                
            
            }
            
            
        }
        
        
        
        func findFlights() {
               if let departure = selectedDiaDiem1, let destination = selectedDiaDiem2 {
                   let filteredFlights = flighttest.filter { (flight) -> Bool in
                       return flight.iddiadiemdi == departure.iddiadiem && flight.iddiadiemden == destination.iddiadiem
                   }
                   flights = filteredFlights
               }
        }
        }
private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}
    struct viewFindPlane_Previews: PreviewProvider {
        static var previews: some View {
            viewFindPlane()
        }
    }
