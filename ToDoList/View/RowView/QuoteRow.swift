//
//  QuoteRow.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import SwiftUI

struct QuoteRow: View {
    let quote: Quote
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(quote.content ?? "")
                        .font(.title3)
                    Spacer()
                    HStack {
                        Text("Added Date:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(quote.dateAdded ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Modified Date:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(quote.dateModified ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Author:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(quote.author ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 12)
        
    }
}


struct DailyQuoteRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(DailyQuoteWrapper().getDailyQuote())
            Text("From DailyQuote")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
