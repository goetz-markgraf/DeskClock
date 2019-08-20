//
//  ViewController.swift
//  DeskClock
//
//  Created by Goetz Markgraf on 03.05.19.
//  Copyright © 2019 Goetz Markgraf. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var clockView: ClockView!
    
    var timer: Timer?

    // Zeigt initial die Zeit an und startet dann den Timer, der die Zeit aktualisiert
    override func viewDidAppear() {
        displayTime()
        startTimer()
    }

    // Am Ende schalte ich den Timer sicherheitshalber aus
    override func viewWillDisappear() {
        timer?.invalidate()
        timer = nil
    }

    // Startet den Timer, der pro Sekunde die Uhrzeit aktualisiert
    func startTimer()
    {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in self.displayTime() })
    }
    
    // Hier wird der View für die Uhrzeit die neue Zeit alss
    // String übergeben
    @objc func displayTime()
    {
        // get the current time
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let nowString = formatter.string(from: now)
        clockView.stringValue = nowString
    }

}

