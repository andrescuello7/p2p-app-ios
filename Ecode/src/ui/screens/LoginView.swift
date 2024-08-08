import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject private var _con = LoginController()
    @State private var navigationPath = NavigationPath()
    @State private var disabled: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Spacer()
                Image("iconApp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
                Button(action: _con.HostEnable ) {
                    if _con.hostEnable {
                        Text(_con.userFactory.userModel.me?.host ?? "Anonymous")
                            .font(.title)
                            .foregroundColor(.gray)
                            .bold()
                    } else {
                        Text("Community")
                            .font(.title)
                            .foregroundColor(.gray)
                            .bold()
                    }
                }
                Text("P2P - The communication is free")
                    .foregroundColor(.gray)
                    .bold()
                    .padding(.bottom, 50)
                
                VStack(spacing: 15) {
                    // TODO: Definition for input
                    // InputView(
                    //     label: "",
                    //     placeholder: "Are You",
                    //     visible: true,
                    //     disabled: disabled,
                    //     input: $_con.username
                    // )
                    InputView(
                        label: "",
                        placeholder: "Address Friend",
                        visible: true,
                        disabled: disabled,
                        input: $_con.host
                    )
                }
                .padding()
                
                HStack {
                    Button(action: {
                        if _con.Genesis() {
                            navigationPath.append(MessageView())
                        }
                    }) {
                        Text("I'm genesis")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.secondary.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        if _con.Login() {
                            navigationPath.append(MessageView())
                        } else {
                            disabled = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    disabled = false
                                }
                            }
                        }
                    }) {
                        Text("Go!")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .padding(.bottom, 100)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationDestination(for: MessageView.self) { view in
                view
            }
        }
    }
}
