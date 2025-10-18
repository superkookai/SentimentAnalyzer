//
//  ResponsePieChartView.swift
//  SentimentAnalyzer
//
//  Created by Weerawut Chaiyasomboon on 18/10/2568.
//

import SwiftUI
import Charts

struct ResponsePieChartView: View {
    let responses: [Response]
    
    init(responses: [Response]) {
        self.responses = responses.sorted(by: {$0.score < $1.score})
    }
    
    var body: some View {
        Chart(responses) { response in
            SectorMark(
                angle: .value("Type", response.score),
                innerRadius: .ratio(0.75)
            )
            .foregroundStyle(by: .value("Sentiment", response.sentiment))
        }
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
        .chartForegroundStyleScale(
            [
                Sentiment.positive: Sentiment.positive.sentimentColor,
                Sentiment.moderate: Sentiment.moderate.sentimentColor,
                Sentiment.negative: Sentiment.negative.sentimentColor
            ]
        )
        .chartBackground { proxy in
            GeometryReader { geo in
                if let anchor = proxy.plotFrame {
                    let frame = geo[anchor]
                    Image(systemName: "location")
                        .resizable()
                        .scaledToFit()
                        .frame(height: frame.height * 0.4)
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        
    }
}

#Preview {
    ResponsePieChartView(responses: [])
}


