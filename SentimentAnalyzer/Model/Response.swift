//
//  Response.swift
//  SentimentAnalyzer
//
//  Created by Weerawut Chaiyasomboon on 18/10/2568.
//

import Foundation

struct Response: Identifiable {
    let id: String
    let text: String
    let score: Double
    
    var sentiment: Sentiment {
        Sentiment(score)
    }
    
    static let sampleResponses: [String] = [
        "AI tools have made my workflow so much faster — I can finish in hours what used to take days!",
        "I feel like everyone is depending too much on AI now, and creativity is starting to disappear.",
        "AI has become a common topic in almost every industry meeting lately.",
        "Thanks to AI assistants, I can finally organize my emails and schedule without stress.",
        "Most companies are exploring which AI tools fit best with their business processes.",
        "Some of these AI-generated results are full of errors; it still needs a lot of human review."
    ]
}
