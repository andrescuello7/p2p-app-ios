//
//  AccountRow.swift
//  Ecode
//
//  Created by Andres Cuello on 31/07/2024.
//

import Foundation
import SwiftUI

struct AccountRow: View {
    var accountName: String
    var amount: String
    var isNegative: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isNegative ? "minus.circle.fill" : "plus.circle.fill")
                .foregroundColor(isNegative ? .red : .green)
                .padding(.trailing, 10)
            
            Text(accountName)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(amount)
                .foregroundColor(isNegative ? .red : .green)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
