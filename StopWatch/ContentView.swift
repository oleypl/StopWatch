//
//  ContentView.swift
//  StopWatch
//
//  Created by Michal on 22/10/2022.
//

import SwiftUI

struct ElapsedTimes: Identifiable {
    let id = UUID()
    let place: Int
    let time: Double
}

struct ContentView: View {
    @State private var buttonStatus: Bool = false
    @ObservedObject var timeManager = TimeManager()
    @State var times = [ElapsedTimes]()
    @State var time = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var count = 0
    @State var to : CGFloat = 0
    @State var place = 1

    init(){
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
    
    
    var body: some View {
        ZStack{
            Color.yellow
            VStack() {
                ZStack {
                    Text(String(format: "%.2f", timeManager.secondsElapsed))
                        .fontWeight(.heavy)
                        .font(.system(size: 50))
                        .multilineTextAlignment(.leading)
                    
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.white.opacity(0.49), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 18, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    
                    
                }
                .padding(.bottom)
                    .padding(.top)
                    .onReceive(self.time) { (_) in
                        if self.buttonStatus{
                            if self.count != 6000{
                                self.count += 1
                                withAnimation(.default){
                                    self.to = CGFloat(self.count) / 6000
                                }
                            }
                            else{
                                self.count = 0
                            }
                        }
                    }
                
                Spacer()
                
                HStack {
                    Button {
                        if(buttonStatus == false) {
                            timeManager.start()
                            buttonStatus.toggle()
                            times.removeAll()
                            self.place = 1
                        }
                        else {
                            times.append(ElapsedTimes(place: place, time: timeManager.secondsElapsed))
                            self.place += 1
                        }
                    } label: {
                            Image(systemName: "stopwatch")
                            .resizable()
                            .frame(width: 50,height: 50)
                    }
                    
                    Button {
                        if(buttonStatus == true){
                            timeManager.stop()
                            buttonStatus.toggle()
                            self.to = 0
                        }
                        self.count = 0
                    } label: {
                            Image(systemName: "square")
                                .resizable()
                                .frame(width: 50,height: 50)
                    }
                    .padding(.horizontal)
                    

                }
                .padding(.vertical)
                    List(times) { time in
                        Text("\(time.place):  \(String(format: "%.2f", time.time))")
                    }.background(.white)
                    .scrollContentBackground(.hidden)
                
                
            }
            .padding(.top, 80)
            
        }.ignoresSafeArea(.all)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
