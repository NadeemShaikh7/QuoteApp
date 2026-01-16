//
//  QuoteWidgetBundle.swift
//  QuoteWidget
//
//  Created by Apple on 14/01/26.
//

import WidgetKit
import SwiftUI

@main
struct QuoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        QuoteWidget()
        QuoteWidgetControl()
        QuoteWidgetLiveActivity()
    }
}
