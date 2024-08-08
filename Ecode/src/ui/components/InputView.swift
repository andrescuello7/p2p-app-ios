import Foundation
import SwiftUI

struct InputView: View {
    var label: String = ""
    var placeholder: String
    var visible: Bool
    var disabled: Bool = false
    @Binding var input: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if label != "" {
                Text(label)
                    .foregroundColor(.gray)
            }
            if visible {
                TextField(placeholder, text: $input)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(.gray)
                    .border(disabled ? Color.red.opacity(0.4) : Color.white.opacity(0.0))
                    .cornerRadius(10)
            } else {
                SecureField("Contraseña", text: $input)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(.gray)
                    .border(disabled ? Color.red.opacity(0.4) : Color.white.opacity(0.0))
                    .cornerRadius(10)
            }
            
        }
    }
}
