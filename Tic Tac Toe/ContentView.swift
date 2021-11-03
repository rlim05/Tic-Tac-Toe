//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Ryan Lim on 11/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9)
    @State private var xTurn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120), spacing: 15), count: 3), content: {
                ForEach(0..<9) { index in
                    ZStack{
                        Color.blue
                        Text(moves [index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                    .onTapGesture {
                        withAnimation(Animation.default) {
                            if moves[index] == "" {
                                moves[index] = xTurn ? "X" : "O"
                                xTurn.toggle()
                            }
                        }
                    }
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                }
            })
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text(winMessage))
        })
        .onChange(of: moves, perform: { value in
            checkForWinner()
        })
    }
    private func checkForWinner() {
        if moves[0] != "" && moves[0] == moves[1] && moves[1] == moves[2] {
            winMessage = "\(moves[0]) is the winner!"
            gameOver = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
