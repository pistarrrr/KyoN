//
//  OnboardingView.swift
//  Energy Management
//
//  Created by Ary Aritonang on 08/05/25.
//


import SwiftUI

// MARK: - Data Model
struct OnboardingPage: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

// MARK: - Sample Pages
let onboardingPages = [
    OnboardingPage(imageName: "OnboardingImageFirst", title: "JOURNALING", description: "Journaling can help reflect on energy conditions and personalization."),
    OnboardingPage(imageName: "OnboardingImageSecond", title: "SEE THE PATTERNS", description: "And over time, spot patterns to gain insight."),
    OnboardingPage(imageName: "OnboardingImageThird", title: "INSIGHTS", description: "Discover Insight Behind Your Energy Pattern.")
]

// MARK: - Page View
struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal, 40)

            Text(page.title)
                .font(.largeTitle)
                .foregroundColor(.darkBlue)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Text(page.description)
                .font(.body)
                .foregroundColor(.darkBlue)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
    }
}

// MARK: - Main Onboarding View
struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isNavigating = false

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        OnboardingPageView(page: onboardingPages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .animation(.easeIn, value: currentPage)

                Button(action: {
                    if currentPage < onboardingPages.count - 1 {
                        currentPage += 1
                    } else {
                        isNavigating = true
                    }
                }) {
                    Text(currentPage < onboardingPages.count - 1 ? "Next" : "Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.lightBlue)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                }

                // Link becomes active when Continue is tapped
                NavigationLink(destination: InputView(), isActive: $isNavigating) {
                    EmptyView()
                }
            }
        }
    }
}
#Preview {
    OnboardingView()
}
