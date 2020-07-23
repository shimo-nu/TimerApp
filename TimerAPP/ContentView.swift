//
//  ContentView.swift
//  TimerAPP
//
//  Created by 下里浩昇 on 2020/07/17.
//  Copyright © 2020 shimo. All rights reserved.
//

import SwiftUI
import Combine

class CountDounTimer: ObservableObject {
    @Published var counter = 10
    var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.counter -= 1
            print(self.counter)
            // ゼロになったらカウントダウン終了
            if 0 >= self.counter {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
}

struct ContentView: View {
    
    @ViewBuilder
    var body: some View {
        TimerView()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct TimerView: View {
    @State var sec: CGFloat = 0.75
    @State var isStart = false
    @State var hour = 0
    @State var minute = 0
    @State var second = 0
    @State var Count = 0
    
    let timer = Timer.publish
    
    var body: some View {
        NavigationView{
            
            VStack{
                //                 NavigationLink(destination: TimeView(),isActive: $isStart){EmptyView()}
                if isStart {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 20)
                            .opacity(0.1)
                        // 4.
                        Circle()
                            .trim(from: 0, to: sec)
                            .stroke(Color.green, lineWidth: 20)
                            .opacity(0.7)
                            .rotationEffect(.degrees(-90))
                            // 5.
                            .overlay(
                                Text(Start())
                        )
                        
                    }.padding(20)
                        .frame(width:300)
                    
                } else {
                    Text("時刻を設定してください")
                    GeometryReader{ geometry in
                        HStack(spacing:0) {
                            Text("時間")
                            Picker(selection: self.$hour, label: Text("時刻")) {
                                ForEach(0 ..< 23){ time in
                                    Text("\(time)").tag(time)
                                }
                            }.labelsHidden()
                                .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                                .clipped()
                            Picker(selection: self.$minute, label: Text("時刻")) {
                                ForEach(0 ..< 59){ time in
                                    Text("\(time)").tag(time)
                                }
                            }.labelsHidden()
                                .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                                .clipped()
                            Picker(selection: self.$second, label: Text("時刻")) {
                                ForEach(0 ..< 60){ time in
                                    Text("\(time)").tag(time)
                                }
                            }.labelsHidden()
                                .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                                .clipped()
                        }
                    }
                }
                
                HStack(spacing: 100) {
                    
                    Button(action: {
                        if !self.isStart{
                                self.Count = self.hour * 3600 + self.minute * 60 + self.second
                        }
                        self.isStart.toggle()
                    }) {
                        Circle()
                            .frame(width:70)
                            .opacity(0.5)
                    }.overlay(Text("Start"))
                    
                    Button(action: {self.isStart.toggle()}) {
                        Circle()
                            .frame(width:70)
                            .opacity(0.5)
                    }.overlay(Text("Stop"))
                }
            }
        }
    }
    
    func Start() -> String {
        var ctr = ""
        if (self.Count <= 0){
            return "Finish!"
        }
        
        self.hour = self.Count / 3600
        self.minute = (self.Count - self.hour * 3600) / 60
        self.second = self.Count - self.hour * 3600 - self.minute * 60
        print(self.hour)
        print(self.minute)
        print(self.second)
        ctr = String(format: "%02d:%02d:%02d", self.hour, self.minute, self.second)
        
        return ctr
        
    }
}
