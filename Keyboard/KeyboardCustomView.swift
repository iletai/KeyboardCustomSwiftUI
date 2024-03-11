//
//  KeyboardCustomView.swift
//  Keyboard
//
//  Created by iletai on 07/03/2024.
//

import SwiftUI
import Observation

@Observable
final class TestModel {
    var pressMeCount = 0
    // var paseBoard = UIPasteboard.general
}

struct KeyboardCustomView: View {
    @Environment(TestModel.self) var testModel
    var body: some View {
        @Bindable var testModel = testModel
        ZStack {
            VStack {
                Text("\(testModel.pressMeCount)")
                HStack {
                    Button {
                        testModel.pressMeCount += 1
                    } label: {
                        Text("A")
                    }
                    Button {
                        testModel.pressMeCount += 1
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
