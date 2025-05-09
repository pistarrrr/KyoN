//
//  DashboardView.swift
//  Energy Management
//
//  Created by Ary Aritonang on 09/05/25.
//

import SwiftUI


struct DashboardView: View {
    @State private var selectedSegment = "Daily"
    private let segments = ["Daily", "Weekly"]
    
    @State private var isNavigating = false  // State for triggering navigation

    var xAxisLabels: [String] {
        selectedSegment == "Daily"
            ? ["3-6", "6-9", "9-12", "12-15", "15-18", "18-21", "21-24"]
            : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }

    let yAxisLabels = ["Thriving", "Balanced", "Neutral", "Struggling", "Depleted"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Top bar
                    HStack {
                        Button(action: { print("Notifications tapped") }) {
                            Image(systemName: "bell")
                        }
                        
                        Spacer()
                        
                        Text("Active Energy")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: { print("Clock tapped") }) {
                            Image(systemName: "clock.arrow.circlepath")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Chart container
                    VStack(alignment: .leading, spacing: 16) {
                        // Segmented control
                        Picker("View", selection: $selectedSegment) {
                            ForEach(segments, id: \.self) { segment in
                                Text(segment).tag(segment)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        GeometryReader { geo in
                            let totalWidth = geo.size.width
                            let totalHeight: CGFloat = 240
                            let yAxisWidth: CGFloat = 60
                            let xAxisHeight: CGFloat = 20
                            let chartWidth = totalWidth - yAxisWidth
                            let chartHeight = totalHeight - xAxisHeight
                            let columns = xAxisLabels.count
                            let rows = yAxisLabels.count
                            let colWidth = chartWidth / CGFloat(columns)
                            let rowHeight = chartHeight / CGFloat(rows)
                            
                            VStack(spacing: 0) {
                                // Main chart area with Y-axis
                                HStack(spacing: 0) {
                                    // Chart grid
                                    ZStack {
                                        Color.white
                                        
                                        // Grid lines
                                        Path { path in
                                            // Horizontal lines
                                            for row in 0...rows {
                                                let y = CGFloat(row) * rowHeight
                                                path.move(to: CGPoint(x: 0, y: y))
                                                path.addLine(to: CGPoint(x: chartWidth, y: y))
                                            }
                                            // Vertical lines
                                            for col in 0...columns {
                                                let x = CGFloat(col) * colWidth
                                                path.move(to: CGPoint(x: x, y: 0))
                                                path.addLine(to: CGPoint(x: x, y: chartHeight))
                                            }
                                        }
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        
                                        Text("Need more data to see the chart")
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: chartWidth, height: chartHeight)
                                    
                                    // Y-axis labels
                                    VStack(spacing: 0) {
                                        ForEach(yAxisLabels, id: \.self) { label in
                                            Text(label)
                                                .font(.caption2)
                                                .frame(height: rowHeight)
                                                .frame(width: yAxisWidth - 5, alignment: .leading)
                                                .padding(.leading, 8)
                                        }
                                    }
                                }
                                
                                // X-axis labels - PERFECTLY ALIGNED SOLUTION
                                HStack(spacing: 0) {
                                    // Start labels immediately after y-axis
                                    ForEach(xAxisLabels, id: \.self) { label in
                                        Text(label)
                                            .font(.caption2)
                                            .frame(width: colWidth, height: xAxisHeight)
                                            .padding(.leading, 1)
                                            .offset(x: -colWidth/0.65)
                                    }
                                }
                                .frame(width: chartWidth)
                                .padding(.leading, yAxisWidth)
                            }
                        }
                        .frame(height: 240)
                        .padding(.horizontal)
                        
                        // Add log energy button
                        Button(action: {
                            isNavigating = true  // Trigger navigation to InputView
                        }) {
                            Text("Add Log Energy")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.lightBlue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        
                        // NavigationLink to InputView when isNavigating is true
                        NavigationLink(destination: InputView(), isActive: $isNavigating) {
                            EmptyView()  // Invisible trigger for navigation
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    // Weekly Insight Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weekly Insight")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack {
                            Text("Need more data to see insight")
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
