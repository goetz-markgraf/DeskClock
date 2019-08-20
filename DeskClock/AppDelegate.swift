//
//  AppDelegate.swift
//  DeskClock
//
//  Created by Goetz Markgraf on 03.05.19.
//  Copyright © 2019 Goetz Markgraf. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Diese Variable hält eine Referenz auf den WindowController, sofern ein Fenster
    // sichtbar ist
    var windowController: NSWindowController? = nil
    
    // Diese Variable hält eine Referenz auf den WindowController für das Preference-Fenster
    var prefWindowController: NSWindowController? = nil
    
    // Das ist die Referenz auf das Symbol in der StatusBar (oben rechts)
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    // Richtet das Statusmenü ein und öffnet das Fenster
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("DeskClock"))
            createMenu()
        }
        showClock(self)
    }

    // Zeigt das Fenster an, sofern noch keines geöffnet ist. Sonst
    // tut die Funktion gar nichts
    @objc func showClock(_ sender: Any)
    {
        if windowController == nil {
            windowController = newWindow()
            windowController!.showWindow(self)
        }
    }

    // Entfernt das Fenster, sofern eines sichtbar ist.
    @objc func hideClock(_ sender: Any)
    {
        if let win = windowController
        {
            win.close()
            windowController = nil
        }
    }
    
    // Zeigt das Preferences-Window an. Zuerst wird geprüft, ob das Fenster noch da ist. Wenn nicht,
    // wird es neu erzeugt
    @objc func preferences(_ sender: Any)
    {
        if (prefWindowController == nil)
        {
            prefWindowController = newPrefWindow()
        } else {
            prefWindowController?.showWindow(nil)
        }
    }

    // Erzeugt das Menü. Merkwürdigerweise konnte ich es nicht direkt
    // aus dem Storyboard holen.
    func createMenu()
    {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Show", action: #selector(showClock(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Hide", action: #selector(hideClock(_:)), keyEquivalent: "h"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(preferences(_:)), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    // Erzeugt einen neuen Window-Controller, indem er aus dem Storyboard
    // instatiiert wird
    func newWindow() -> NSWindowController
    {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let indentifier = NSStoryboard.SceneIdentifier("Clock Window Controller")
        guard let windowController = storyboard.instantiateController(withIdentifier: indentifier) as? NSWindowController else
        {
            fatalError("I cannot find my controller -> check Main.storyboard")
        }
        return windowController
    }
    
    func newPrefWindow() -> NSWindowController
    {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    }
}

