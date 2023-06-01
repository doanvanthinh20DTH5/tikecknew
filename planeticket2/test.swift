//
//  test.swift
//  planeticket2
//
//  Created by DoanThinh on 5/15/23.
//

import SwiftUI

struct test: View {
    @State private var selectedDate = Date()

      var body: some View {
          Form {
              Section {
                  DatePicker("Ngày sinh", selection: $selectedDate, displayedComponents: [.date])
                      .datePickerStyle(.compact)
              }
              
              Button(action: {
                  // Xử lý khi bấm nút
                  print("Ngày sinh đã chọn: \(selectedDate)")
              }) {
                  Text("Lưu")
              }
          }
      }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
