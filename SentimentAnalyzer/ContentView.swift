//
//  ContentView.swift
//  SentimentAnalyzer
//
//  Created by Weerawut Chaiyasomboon on 18/10/2568.
//

import SwiftUI

struct ContentView: View {
    @State private var responseText = ""
    @State private var responses: [Response] = []
    @State private var scorer = Scorer()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ResponsePieChartView(responses: responses)
                    
                    OverallSentimentSection(responses: responses)
                    
                    ForEach(responses) { response in
                        ResponseRowView(response: response)
                            .padding(.horizontal)
                    }
                }
                
                HStack {
                    TextField("Your thougths on the future of AI...", text: $responseText, axis: .vertical)
                        .padding(12)
                        .padding(.leading, 4)
                        .lineLimit(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(uiColor: .systemGray4) ,lineWidth: 1)
                        }
                    
                    Button("Done") {
                        withAnimation {
                            onDoneTapped()
                        }
                    }
                    .fontWeight(.semibold)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .task {
            for responseText in Response.sampleResponses {
                saveResponse(responseText)
            }
        }
    }
}

private extension ContentView {
    func saveResponse(_ text: String, shouldInsert: Bool = false) {
        let score = self.scorer.score(text)
        let response = Response(id: UUID().uuidString, text: text, score: score)
        if shouldInsert {
            self.responses.insert(response, at: 0)
        } else {
            self.responses.append(response)
        }
    }
    
    func onDoneTapped() {
        guard !responseText.isEmpty else { return }
        saveResponse(responseText, shouldInsert: true)
        responseText = ""
    }
}

#Preview {
    ContentView()
}
