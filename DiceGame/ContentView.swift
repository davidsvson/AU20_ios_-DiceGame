//
//  ContentView.swift
//  DiceGame
//
//  Created by David Svensson on 2021-01-21.
//

/****************************
*
*       Skapa ett tärningspel där man slår 2 tärningar. Efter valfritt antal slag kan omgången avslutas och då sparas hittils uppnådda
*       poäng. Om poängen för en omgång skulle överskrida 21 så blir poängen i stället 0 för den omgången.
*       Målet är att få 100p på så få omgångar som möjligt.
*
*********************************/



import SwiftUI

struct ContentView: View {
    @State var diceNumber1 = 3
    @State var diceNumber2 = 5
    @State var sum = 0
    @State var showingBustSheet = false
    
    var body: some View {
        ZStack {
            Color(red: 11.0/256 , green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            
            VStack {
                
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }.onAppear() {
                    roll()
                }
                Spacer()
                Button(action: {
                    roll()
                }) {
                    Text("Roll")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
                .cornerRadius( 15.0)
                Spacer()
                
            }
        }
        .sheet(isPresented: $showingBustSheet, onDismiss: { sum = 0 }) {
            
            BustSheet(sum: sum)
        }
    }
    
    func roll() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
        sum += diceNumber1 + diceNumber2
        if sum > 21 {
            showingBustSheet = true
        }
        //showingBustSheet = sum > 21
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //BustSheet(sum: 55)
    }
}

struct BustSheet : View {
    let sum : Int
    
    var body: some View {
        ZStack {
            Color(red: 11.0/256 , green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            
            VStack {
                Text("Bust")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

struct DiceView: View {
    let n: Int
    
    var body: some View {
        Image(systemName: "die.face.\(n)" )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
