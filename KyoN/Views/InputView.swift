//
//  InputView.swift
//  Energy Management
//
//  Created by Ary Aritonang on 09/05/25.
//

import SwiftUI


// MARK: - Data Model for Input
struct InputPage: Identifiable {
    let id = UUID()
    let title: String
    let question: String
    let options: [String]
}

// MARK: - Sample Pages
let inputPages = [
    InputPage(title: "Physical", question: "How energetic and fit your body right now??", options: ["My body feels strong, rested and ready for action", "I am functional but not at my best", "I have enough energy for basics, nothing extra", "My body feels off (tired,achy bloated)", "My body feels broken (Chronic pain, no energy)"]),
    InputPage(title: "Emotional", question: "How do you feel right now?", options: ["I feel calm, grateful, and handle stress well", "I manage emotions but accasconally snap", "I emotionally flat, no high or lows", "Small things irritate me, or feel nothing", "I can’t Focus or care about anything"]),
    InputPage(title: "Mental", question: "How is your current state of mind?", options: ["My mind is sharp, creative, and unstoopable", "I can work but need break", "I can think but not deeply or creatively", "My brain feels foggy or overwhelmed", "I can’t focus or care about anything"])
]

// MARK: - Main View
struct InputView: View {
    @State private var currentPage = 0
    @State private var answers: [String] = Array(repeating: "", count: inputPages.count)
    @State private var showReflectionView = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            if showReflectionView {
                ReflectionInputView(
                    answers: answers,
                    onBack: {
                        showReflectionView = false
                        currentPage = 2 // go back to third input page
                    },
                    onDone: { reflection in
                        print("Reflection submitted: \(reflection)")
                        // Handle completion
                    }
                )
            } else {
                InputPageView(
                    page: inputPages[currentPage],
                    pageIndex: currentPage,
                    totalPages: inputPages.count,
                    onBack: {
                        if currentPage == 0 {
                            dismiss()
                        } else {
                            currentPage -= 1
                        }
                    },
                    onSelect: { selected in
                        answers[currentPage] = selected
                        if currentPage < inputPages.count - 1 {
                            currentPage += 1
                        } else {
                            // All inputs done, move to reflection screen
                            showReflectionView = true
                        }
                    }
                )
            }
        }
    }
}


// MARK: - Single Input Page View
struct InputPageView: View {
    let page: InputPage
    let pageIndex: Int
    let totalPages: Int
    let onBack: () -> Void
    let onSelect: (String) -> Void

    var body: some View {
        VStack {
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

                Text(page.title)
                    .font(.headline)

                Spacer()

                Text("\(pageIndex + 1) of \(totalPages)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding()
            }

            Spacer()

            // Question
            Text(page.question)
                .font(.title.bold())
                .foregroundColor(.lightBlue)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 85)

            // Answer Buttons
            VStack(spacing: 16) {
                ForEach(page.options, id: \.self) { option in
                    Button(action: {
                        onSelect(option)
                    }) {
                        Text(option)
                            .font(.body)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.70), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal, 30)
                }
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InputView()
}

