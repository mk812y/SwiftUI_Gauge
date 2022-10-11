//
//  ContentView.swift
//  SwiftUI_Gauge
//
//  Created by Михаил Куприянов on 11.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State var progress = 0.7
    @State private var currentSpeed = 100.0
    
    var body: some View {
        VStack {
            Gauge(value: progress) {
                Text("Upload status")
            }
            Gauge(value: progress) {
                Text("")
            } currentValueLabel: {
                Text(progress.formatted(.percent))
            } minimumValueLabel: {
                Text(0.formatted(.percent))
            } maximumValueLabel: {
                Text(100.formatted(.percent))
            }
            Gauge(value: currentSpeed, in: 0...200) {
                Text("Speed")
            } currentValueLabel: {
                Text("\(currentSpeed.formatted(.number)) km/h")
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            Gauge(value: currentSpeed, in: 0...200) {
                Image(systemName: "gauge")
                    .font(.title)
            } currentValueLabel: {
                HStack {
                    Image(systemName: "gauge.low")
                    Text("\(currentSpeed.formatted(.number)) km/h")
                    Image(systemName: "gauge.high")
                }
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            .tint(.red)
            addGaugeStyle
            Gauge(value: currentSpeed, in: 0...200) {
                   Image(systemName: "gauge.medium")
                       .font(.system(size: 50.0))
               } currentValueLabel: {
                   Text("\(currentSpeed.formatted(.number))")
               }
               .gaugeStyle(SpeedometerGaugeStyle())
        }
        .padding()
    }
    
    var addGaugeStyle: some View {
        Group {
            Gauge(value: currentSpeed, in: 0...200) {
                Image(systemName: "gauge.medium")
                    .font(.largeTitle)
            } currentValueLabel: {
                HStack {
                    Image(systemName: "gauge.low")
                    Text("\(currentSpeed.formatted(.number)) km/h")
                    Image(systemName: "gauge.high")
                }
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            .gaugeStyle(.accessoryLinear)
            Gauge(value: currentSpeed, in: 0...200) {
                Image(systemName: "gauge")
            } currentValueLabel: {
                HStack {
                    Image(systemName: "gauge")
                    Text("\(currentSpeed.formatted(.number)) km/h")
                }
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            .gaugeStyle(.accessoryLinearCapacity)
            Gauge(value: currentSpeed, in: 0...200) {
                Image(systemName: "gauge")
            } currentValueLabel: {
                HStack {
                    Text("\(currentSpeed.formatted(.number)) km/h")
                }
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            .gaugeStyle(.accessoryCircular)
            Gauge(value: currentSpeed, in: 0...200) {
                Image(systemName: "gauge")
            } currentValueLabel: {
                HStack {
                    Text("\(currentSpeed.formatted(.number))")
                }
            } minimumValueLabel: {
                Text(0.formatted(.number))
            } maximumValueLabel: {
                Text(200.formatted(.number))
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.red)
        }
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SpeedometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(.red), Color(.blue)
        ]),
        startPoint: .trailing,
        endPoint: .leading)
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.systemGray6))
            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color(.black), style: StrokeStyle(
                    lineWidth: 10,
                    lineCap: .butt,
                    lineJoin: .round,
                    dash: [1, 34],
                    dashPhase: 0.0
                ))
                .rotationEffect(.degrees(135))
            
            VStack {
                configuration.currentValueLabel
                    .font(.system(
                        size: 80,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundColor(.gray)
                Text("km/h")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 300, height: 300)
    }
    
    
    
}
