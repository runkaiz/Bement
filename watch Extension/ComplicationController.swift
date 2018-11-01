//
//  ComplicationController.swift
//  temp Extension
//
//  Created by Runkai Zhang on 10/21/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let HOUR: TimeInterval = 60 * 60
    let MINUTE: TimeInterval = 60
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        var daysLeft = Int()
        var termName = String()
        var count = 0
        let calendar = NSCalendar.current
        var fraction = Float()
        var gaugeColor = UIColor()
        for item in database.terms {
            
            let date = UpcomingInterfaceController.component2Date(item)
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: date as Date)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if date as Date > Date() {
                daysLeft = components.day!
                termName = database.names[count]
                let ratio = (Float(daysLeft) / 28 as Float) as Float
                fraction = Float(1 - ratio)
                //print("the fraction is \(fraction), and the ratio is \(ratio), the days left is \(daysLeft)")
                if fraction <= 0.5 {
                    gaugeColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
                } else if fraction <= 75 {
                    gaugeColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
                } else if fraction <= 99{
                    gaugeColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                } else {
                    gaugeColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
                }
                break
            } else {
                count += 1
            }
        }
        
        switch complication.family {
        case .modularLarge:
            let entry = createTimeLineEntryModularLargeStandardBody(headerText: "Days Left: ", bodyText1: "\(daysLeft)", bodyText2: termName, date: NSDate())
            handler(entry)
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKSimpleTextProvider(text: "End of \(termName) in \(daysLeft) Days", shortText: "\(termName) in \(daysLeft) Days")
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerGaugeText()
            let leadingText = CLKSimpleTextProvider(text: "Beg")
            let trailingText = CLKSimpleTextProvider(text: "End")
            leadingText.tintColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
            trailingText.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: gaugeColor, fillFraction: fraction)
            template.leadingTextProvider = leadingText
            template.trailingTextProvider = trailingText
            template.outerTextProvider = CLKSimpleTextProvider(text: "term")
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        default:
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    func createTimeLineEntryModularLargeStandardBody(headerText: String, bodyText1: String, bodyText2: String, date: NSDate) -> CLKComplicationTimelineEntry {
        
        let template = CLKComplicationTemplateModularLargeStandardBody()
        
        let header = CLKSimpleTextProvider(text: headerText)
        let body1 = CLKSimpleTextProvider(text: bodyText1)
        let body2 = CLKSimpleTextProvider(text: bodyText2)
        
        header.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        
        template.headerTextProvider = header
        template.body1TextProvider = body1
        template.body2TextProvider = body2
        
        let entry = CLKComplicationTimelineEntry(date: date as Date,
                                                 complicationTemplate: template)
        
        return(entry)
    } 
    
}
