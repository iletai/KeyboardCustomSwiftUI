//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by iletai on 07/03/2024.
//

import UIKit
import SwiftUI
import KeyboardKit

class KeyboardViewController: KeyboardKit.KeyboardInputViewController {
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                renderBackground: false,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in KeyboardCustomView() }
            )
        }
    }
}
