//
//  ContentView.swift
//  MyTimer
//
//  Created by Nana Fujita on 2024-07-07.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var timerHandler: Timer?
    
    
    @State var count = 0
    
    
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                
                Image(.backgroundTimer)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(spacing: 30.0) {
                    Text("\(timerValue - count) Seconds")
                        .font(.largeTitle)
                    
                    HStack {
                        Button{
                            startTimer()
                        } label: {
                            Text("Start")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height:140)
                                .background(Color.start)
                                .clipShape(Circle())
                        }
                        
                        
                        Button {
                            if let timerHandler {
                                if timerHandler.isValid == true {
                                    timerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("Stop")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width:140,height:140)
                                .background(Color.stop)
                                .clipShape(Circle())
                            
                        }
                    }
                    
                    
                    
                }
            }
            
            .onAppear {
                count = 0
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("Timer Setting")
                    }
                }
            }
        }
    }
    
    func countDownTimer(){
        count+=1
        
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
        }
    }
    
    func startTimer(){
        if let timerHandler {
            if timerHandler.isValid == true {
                return
            }
        }
        
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval:1, repeats: true) {
            _ in
            countDownTimer()
        }
    }
}

#Preview {
    ContentView()
}
