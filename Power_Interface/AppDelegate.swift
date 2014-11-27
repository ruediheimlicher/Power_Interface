//
//  AppDelegate.swift
//  Power_Interface
//
//  Created by Ruedi Heimlicher on 02.11.2014.
//  Copyright (c) 2014 Ruedi Heimlicher. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate , NSWindowDelegate
{
   
   @IBOutlet weak var  Fenster: NSViewController!
   func applicationDidFinishLaunching(aNotification: NSNotification)
   {
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "fertigAktion:", name: "NSWindowWillCloseNotification", object: nil)
      // Insert code here to initialize your application
      
      
      var fensterArray  = NSApplication.sharedApplication().windows
   //   println("topControllers: \(topControllers[0].description)")
      var f   = NSApplication.sharedApplication().windows.count
      var hauptfenster = fensterArray[0] as NSWindow
      
      var a = hauptfenster.opaque
      var farbe:NSColor = NSColor(red: 200/255, green: 235/255, blue: 210/255, alpha: 1.0)
      hauptfenster.backgroundColor = farbe
      
      var wc = fensterArray[0].windowController() as NSWindowController

      //  println(a)
      // http://stackoverflow.com/questions/6633168/passing-data-from-viewcontroller-to-appdelegate
   //   NSApplication.sharedApplication().sendAction("start_read_USB:", to: nil, from: self)
      
   }
   

   func applicationWillTerminate(aNotification: NSNotification)
   {
      // Insert code here to tear down your application
      
      NSLog("Schluss")
   }

   func windowShouldClose(sender: AnyObject)-> Bool
   {
     // NSLog("Sollte Schliessen")
      return true
   }
   
   func fertigAktion(sender: AnyObject)-> Bool
   {
      NSLog("fertigAktion will schliessen")
      //var hauptfenster:NSWindow   = NSApplication.sharedApplication().mainWindow!
      //var v  = hauptfenster.contentView as NSView
      
      //var w = v.frame.size.width
      
      //println("width: \(w)")

      
      
      NSApplication.sharedApplication().terminate(self)
      return true
   }

   func windowWillClose(sender: AnyObject)-> Bool
   {
      //NSLog("Will Schliessen")
      return true
   }

}


