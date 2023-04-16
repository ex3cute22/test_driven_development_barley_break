//
//  GameView.swift
//  TDD3_BarleyBreak
//
//  Created by Илья Викторов on 16.04.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = BarleyBreakGame()
    @State var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    @State var isRunning = false {
        didSet {
            if isRunning {
                game.counter = 0
            }
        }
    }
    @State var showAlert = false {
        didSet {
            if showAlert {
                isRunning.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            LinearGradient(
                colors: [.red, .blue, .green, .yellow],
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask(
                Text("Количество ходов: \(game.counter)")
                    .font(.system(size: 26, weight: .bold, design: .rounded) )
            )
            .frame(height: 60)
            .padding(.bottom, 30)
            
            LazyVGrid(columns: columns) {
                ForEach(game.items, id: \.self) {i in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            if !isRunning {
                                isRunning.toggle()
                            }
                            
                            game.moveItem(value: i)
                            if game.checkFoVictory() {
                                showAlert.toggle()
                            }
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.blue)
                                .frame(height: 80)
                                .shadow(radius: 2)
                            Text("\(i)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                    }
                    .buttonStyle(ButtonForItemStyle())
                    .opacity(i == 16 ? 0 : 1)
                }
            }
            .onAppear {
                withAnimation(.spring()) {
                    game.createNewGame()
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Поздравляем!!!"),
                message: Text("Начать заново?")
            )
    }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct ButtonForItemStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6), value: configuration.isPressed)
    }
}
