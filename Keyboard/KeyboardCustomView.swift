//
//  KeyboardCustomView.swift
//  Keyboard
//
//  Created by iletai on 07/03/2024.
//

import SwiftUI

struct KeyboardCustomView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                    } label: {
                        Text("Thủ nhà")
                    }
                    Button {
                    } label: {
                        Text("Define lính")
                    }
                    Button {
                    } label: {
                        Text("Ăn rồng")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }
}

#Preview {
    KeyboardCustomView()
}
