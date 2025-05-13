//
//  ReflectionInputView.swift
//  Energy Management
//
//  Created by Ary Aritonang on 09/05/25.
//

import SwiftUI

struct ReflectionInputView: View {
    let answers: [String]  // Expected to be in order: Physical, Emotional, Mental
    let onBack: () -> Void
    let onDone: (String) -> Void

    @State private var reflectionText = ""
    @State private var isNavigating = false  // State to control navigation

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Top bar
                HStack {
                    Button(action: onBack) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                    }
                    Spacer()
                }

                // Summary container
                VStack(alignment: .leading, spacing: 9) {
                    Group {
                        Text("Physical")
                            .font(.headline)
                            .foregroundColor(.lightBlue)

                        Divider()
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 1)
                            .background(Color.black)

                        Text(answers[0])
                            .font(.body)
                            .padding(.bottom, 8)

                        Text("Emotional")
                            .font(.headline)
                            .foregroundColor(.lightBlue)

                        Divider()
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 1)
                            .background(Color.black)

                        Text(answers[1])
                            .font(.body)
                            .padding(.bottom, 8)

                        Text("Mental")
                            .font(.headline)
                            .foregroundColor(.lightBlue)

                        Divider()
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 1)
                            .background(Color.black)

                        Text(answers[2])
                            .font(.body)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.70), radius: 3, x: 0, y: 2)
                .padding(.horizontal, 30)

                // Reflection input container
                VStack(alignment: .leading, spacing: 10) {
                    Text("Do you have something to reflect on right now?")
                        .font(.headline)
                        .foregroundColor(.lightBlue)

                    Divider()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 1)
                        .background(Color.black)

                    TextEditor(text: $reflectionText)
                        .frame(height: 150)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.70), radius: 3, x: 0, y: 2)
                .padding(.horizontal, 30)

                Spacer()

                // Done button
                Button(action: {
                    onDone(reflectionText)  // This is to pass reflection text if needed
                    isNavigating = true  // Trigger navigation to DashboardView
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBlue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)

                // NavigationLink to DashboardView when isNavigating is true
                NavigationLink(destination: DashboardView(), isActive: $isNavigating) {
                    EmptyView()  // Invisible trigger for navigation
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ReflectionInputView(
        answers: [
            "You’re functional but not at your best",
            "You manage emotions but occasionally snap",
            "You can think but not deeply or creatively"
        ],
        onBack: {
            print("Back tapped in preview")
        },
        onDone: { reflection in
            print("Done tapped with reflection: \(reflection)")
        }
    )
}
