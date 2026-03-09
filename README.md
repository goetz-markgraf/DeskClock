# DeskClock

A simple macOS desktop clock application that displays the current time in a floating window.

## Description

DeskClock is a lightweight macOS menu bar application that shows a floating clock on your desktop. The clock runs as a menu bar utility and can be toggled on and off from the status bar.

## Features

- Floating desktop clock with customizable appearance
- Lives in the macOS menu bar for easy access
- Toggle clock visibility from the status bar
- Clean, minimal design
- Runs as a background utility (LSUIElement)

## Requirements

- macOS 10.12 or later
- Xcode (for building from source)

## Building

1. Clone the repository
2. Open `DeskClock.xcodeproj` in Xcode
3. Build and run the project

## Project Structure

- `AppDelegate.swift` - Main application delegate and menu bar management
- `ClockView.swift` - Custom view for rendering the clock display
- `ClockWindowController.swift` - Window controller for the clock window
- `ViewController.swift` - Main view controller

## License

Copyright © 2019 Goetz Markgraf. All rights reserved.

## Author

Created by Goetz Markgraf
