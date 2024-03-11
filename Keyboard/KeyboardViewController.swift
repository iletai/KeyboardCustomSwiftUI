//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by iletai on 07/03/2024.
//

import UIKit
import SwiftUI
import KeyboardKit
import Observation

@Observable
class KeyboardViewController: KeyboardKit.KeyboardInputViewController {
    var testViewModel = TestModel()

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                renderBackground: true,
                buttonContent: { contentBtn in
                    contentBtn.view
                },
                buttonView: { viewBtn in
                    viewBtn.view
                },
                emojiKeyboard: { emojiKeyboard in
                    emojiKeyboard.view
                },
                toolbar: { _ in
                    KeyboardCustomView().environment(self.testViewModel)
                }
            )
        }
    }

    override func viewDidLoad() {
        services.layoutProvider = DemoLayoutProvider()
        state.keyboardContext.setLocale(.english)
        services.styleProvider = DemoStyleProvider(
            keyboardContext: state.keyboardContext)
    }
}


class DemoLayoutProvider: StandardKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        layout.tryInsertRocketButton()
        layout.tryInsertLocaleSwitcher(for: context)
        return layout
    }
}

private extension KeyboardLayout {

    func tryInsertLocaleSwitcher(for context: KeyboardContext) {
        guard context.hasMultipleLocales else { return }
        guard let button = tryCreateBottomRowItem(for:  .nextLocale) else { return }
        itemRows.insert(button, after: .space, atRow: bottomRowIndex)
    }

    func tryInsertRocketButton() {
        guard let button = tryCreateBottomRowItem(for:  .character("🐃")) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }
}

class DemoStyleProvider: StandardKeyboardStyleProvider {
    override var backgroundStyle: KeyboardStyle.Background {
        KeyboardStyle.Background(
            backgroundColor: Color.gray.opacity(0.01),
            backgroundGradient: nil,
            imageData: nil,
            imageContentMode: KeyboardStyle.Background.ImageContentMode.fit,
            overlayColor: .clear,
            overlayGradient: nil
        )
    }

    override var keyboardLayoutConfiguration: KeyboardLayout.Configuration {
        .init(
            buttonCornerRadius: 12,
            buttonInsets: EdgeInsets(top: 0, leading: 2, bottom: 2, trailing: 2),
            rowHeight: 12
        )
    }

    override func buttonFontSize(
        for action: KeyboardAction
    ) -> CGFloat {
        let standard = super.buttonFontSize(for: action)
        return action.isRocket ? 1.8 * standard : standard
    }

    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        if action.isRocket {
            return super.buttonStyle(for: .backspace, isPressed: isPressed)
        }
        return super.buttonStyle(for: action, isPressed: isPressed)
    }
}

private extension KeyboardAction {

    var isRocket: Bool {
        switch self {
        case .character(let char): return char == "🐃"
        default: return false
        }
    }
}
