//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 柳铭坤 on 2023/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var chancesLeft = 8
    
    var body: some View {
        
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
//                           startPoint: .top,
//                           endPoint: .bottom)
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                center: .top,
                startRadius: 200,
                endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                if chancesLeft >= 1 {
                    
                }
                VStack(spacing: 15) {
                    
                    if chancesLeft >= 1 {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundColor(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnswer].uppercased())
    //                            .foregroundColor(.white)
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                    } else {
                        Button {
                            reset()
                        } label: {
                            Text("Restart")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .padding(.bottom, 10)
                
                Text("Chances left: \(chancesLeft)")
                    .foregroundColor(.white)
                    .font(.title3)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
    }
    
    // After tapping, show the result: True/False
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Correct, your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Wrong! The answer is \(countries[correctAnswer])"
        }
        
        showingScore = true
        chancesLeft -= 1
    }
    
    // After answering the question, present a new question
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        chancesLeft = 8
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
