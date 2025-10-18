//
//  Sentiment.swift
//  SentimentAnalyzer
//
//  Created by Weerawut Chaiyasomboon on 18/10/2568.
//

import Charts
import SwiftUI

enum Sentiment: String, Plottable, CaseIterable, Identifiable {
    case positive = "Positive"
    case moderate = "Moderate"
    case negative = "Negative"
    
    var id: String {
        rawValue
    }
    
    init(_ score: Double) {
        if score > 0.2 {
            self = .positive
        } else if score < -0.2 {
            self = .negative
        } else {
            self = .moderate
        }
    }
    
    var icon: String {
        switch self {
        case .positive:
            "chevron.up.2"
        case .moderate:
            "minus"
        case .negative:
            "chevron.down.2"
        }
    }
    
    var sentimentColor: Color {
        switch self {
        case .positive:
                .teal
        case .moderate:
                .gray
        case .negative:
                .red
        }
    }
}
