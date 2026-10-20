//
//  ClockWindow.swift
//  DeskClock
//
//  Created by Goetz Markgraf on 03.05.19.
//  Copyright © 2019 Goetz Markgraf. All rights reserved.
//

import Cocoa

class ClockWindowController: NSWindowController
{
    
    let FRAME_KEY = "DeskClockFrame"
    
    // richtet das Fenster nach dem öffnen so ein, dass es immer vorne bleibt
    // Außerdem erzeuge ich einen Event-Handler, der beim schließen die Position abspeichert
    override func windowDidLoad() {
        super.windowDidLoad()

        window?.collectionBehavior = .canJoinAllSpaces
        window?.level = .floating

        NotificationCenter.default.addObserver(self, selector: #selector(windowWillClose(_:)), name: NSWindow.willCloseNotification, object: nil)
    }

    func toggleSeconds() {
        let vc = window?.contentViewController as? ViewController
        vc?.toggleSeconds()
    }

    // Beim öffnen hole ich die Fensterposition aus den UserDefaults
    override func awakeFromNib() {
        super.awakeFromNib()
                
        guard let data = UserDefaults.standard.data(forKey: FRAME_KEY) else {
            return
        }
            
        do {
            if let frame = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSValue.self, from: data) as? NSRect {
                
                window?.setFrame(frame, display: true)
            }
            
        } catch {
            print ("Cannot restore frame rect")
        }
        
    }
    
    // Das hier wird beim schließen durch die Notification aus "windowDidLoad"
    // angesprungen. Die Funktion speichert die Fensterposition in den
    // UserDefaults
    @objc func windowWillClose(_ notification: Notification)
    {
        guard let frame = window?.frame else {
            return
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: frame, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: FRAME_KEY)
        } catch {
            print ("Cannot store frame rect")
        }
    }
}
