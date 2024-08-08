import Foundation
import SwiftUI

struct AdView: View {
    var icon: String
    var title: String
    var subtitle: String
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(15)
    }
}
