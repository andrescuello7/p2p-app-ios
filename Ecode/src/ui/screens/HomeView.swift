import Foundation
import SwiftUI

struct HomeView: View, Hashable {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                    Text("Julio")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                VStack(spacing: 10) {
                    Text("Balance de Cuenta")
                        .foregroundColor(.gray)
                    
                    Text("$ 870,000.00")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "eye")
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.9))
                .cornerRadius(15)
                
                // Income and expenses section
                HStack {
                    VStack {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.green)
                        
                        Text("Ingreso")
                            .foregroundColor(.gray)
                        
                        Text("$ 870,000.00")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundColor(.red)
                        
                        Text("Egreso")
                            .foregroundColor(.gray)
                        
                        Text("-$ 10,000.00")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Watch an ad to sync your account")
                            .font(.headline)
                            .padding(.top)
                        
                        HStack {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.white)
                            VStack(alignment: .leading) {
                                Text("Sincronizar Card")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.white)
                                Text("agregar tarjeta para credito")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                            VStack(alignment: .leading) {
                                Text("Promocion del 30% OFF")
                                    .font(.body)
                                    .bold()
                                Text("Suscribete y obten descuento de la App")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Cuentas")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.gray)
                    AccountRow(accountName: "Billetera", amount: "$ 870,000.00", isNegative: false)
                    AccountRow(accountName: "Gastos", amount: "-$ 10,000.00", isNegative: true)
                }
                .padding()
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Background color for the entire view
    }
}
