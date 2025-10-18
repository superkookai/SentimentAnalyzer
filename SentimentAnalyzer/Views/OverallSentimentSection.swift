//
//  OverallSentimentSection.swift
//  SentimentAnalyzer
//
//  Created by Weerawut Chaiyasomboon on 18/10/2568.
//

import SwiftUI

struct OverallSentimentSection: View {
    let responses: [Response]
    
    var body: some View {
        GroupBox {
            if let overallSentiment {
                HStack {
                    Label("Learning Positive", systemImage: "minus")
                        .font(.headline)
                        .foregroundStyle(overallSentiment.sentimentColor)
                    Spacer()
                    Text("\(responses.count) responses")
                }
                .padding(.bottom)
                
                HStack(spacing: 16) {
                    ForEach(Sentiment.allCases) { sentiment in
                        SentimentPill(sentiment: sentiment, pct: percentage(sentiment: sentiment))
                    }
                }
                
            } else {
                Text("No responses yet...")
            }
        } label: {
            Label("Overall Sentiment", systemImage: "chart.pie.fill")
        }
        .padding()
    }
}

struct SentimentPill: View {
    let sentiment: Sentiment
    let pct: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName: sentiment.icon)
                    .imageScale(.small)
                Text(sentiment.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            Text("\(pct)%")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(sentiment.sentimentColor.opacity(0.12), in: .capsule)
        .overlay {
            Capsule()
                .strokeBorder(sentiment.sentimentColor.opacity(0.35), lineWidth: 0.5)
        }
        .foregroundStyle(sentiment.sentimentColor)
    }
}

private extension OverallSentimentSection {
    func percentage(sentiment: Sentiment) -> Int {
        guard !responses.isEmpty else { return 0}
        print(sentimentMap)
        let count = sentimentMap[sentiment, default: 0]
        return Int(Double(count)/Double(totalResponses)*100)
    }
    
    var totalResponses: Int {
        responses.count
    }
    
    var sentimentMap: [Sentiment: Int] {
//        Dictionary(grouping: responses, by: \.sentiment).mapValues(\.count)
        var map: [Sentiment: Int] = [:]
        for response in self.responses {
            map[response.sentiment, default: 0] += 1
        }
        return map
    }
    
    var overallSentiment: Sentiment? {
        guard responses.count > 0 else { return nil }
        
//        var map: [Sentiment: Int] = [:]
//        for response in self.responses {
//            map[response.sentiment, default: 0] += 1
//        }
//        
//        var maxValue = 0
//        var result: Sentiment?
//        for (key, value) in map {
//            maxValue = max(maxValue,value)
//            if maxValue == value {
//                result = key
//            }
//        }
//        
//        return result
        
        return sentimentMap.max(by: {$0.value < $1.value})?.key
    }
}

#Preview {
    OverallSentimentSection(responses: [
        .init(id: UUID().uuidString, text: "Test response", score: 0.5),
        .init(id: UUID().uuidString, text: "Test response2", score: 0.5),
        .init(id: UUID().uuidString, text: "Test response3", score: -0.3),
        .init(id: UUID().uuidString, text: "Test response4", score: 0.1)
    ])
}


