//
//  ClockView.swift
//  DeskClock
//
//  Created by Goetz Markgraf on 04.05.19.
//  Copyright © 2019 Goetz Markgraf. All rights reserved.
//

import Cocoa

class ClockView: NSView
{
    required init? (coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    // Der didSet-Block ist wichtig, damit bei einer Veränderung
    // auch die View neu gezeichnet wird
    var stringValue: String = ""
    {
        didSet {
            needsDisplay = true
        }
    }

    // Diese Funktion zeichnet die View
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Zuerst mache ich alles schwarz
        NSColor.controlBackgroundColor.setFill()
        dirtyRect.fill()
        
        // Dann hole ich den String und zwar als NSString Objekt, da ich dort
        // automatisch die Funktion zum malen finde
        let text = NSString(string: stringValue)
        
        // Hier setze ich die Parameter für den Text (Schriftgröße etc.)
        let font = NSFont(name: "Arial Bold", size: 35)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .center
        
        
        // Ich muss den font auf nil prüfen
        if let actualFont = font {
            // Erst den Text in weiß drucken
            var textAttributes: [NSAttributedString.Key : Any] = [
                .font: actualFont,
                .foregroundColor: NSColor.textColor,
                .paragraphStyle: textStyle
            ]
            let shadowRect = bounds.offsetBy(dx: 1.0, dy: -1.0)
           
            text.draw(in: shadowRect, withAttributes: textAttributes)
            
            // Und dann in der Akzentfarbe
            textAttributes = [
                .font: actualFont,
                .foregroundColor: NSColor.controlAccentColor /* selectedControlColor oder controlAccentColor */,
                .paragraphStyle: textStyle
            ]
            
            text.draw(in: bounds, withAttributes: textAttributes)
        }
    }
}
