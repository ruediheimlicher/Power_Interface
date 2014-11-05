//
//  ViewController.swift
//  Power_Interface
//
//  Created by Ruedi Heimlicher on 02.11.2014.
//  Copyright (c) 2014 Ruedi Heimlicher. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
   
   // var  myUSBController:USBController
   // var usbzugang:
   var usbstatus: Int32 = 0
   
   var usb_read_OK = false;
   
   var teensy = usb_teensy()
   
   @IBOutlet weak var manufactorer: NSTextField!
   @IBOutlet weak var Counter: NSTextField!
   
   @IBOutlet weak var Start: NSButton!
   
   @IBOutlet weak var inputFeld: NSTextField!
   
   @IBOutlet weak var USB_OK: NSOutlineView!
   
   @IBOutlet weak var start_read_USB_Knopf: NSButtonCell!
   
   @IBOutlet weak var codeFeld: NSTextField!
   
   @IBOutlet weak var dataFeld: NSTextField!
   
   @IBOutlet weak var H_Feld: NSTextField!
   
   @IBOutlet weak var L_Feld: NSTextField!
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      let xy = Hello()
      USB_OK.backgroundColor = NSColor.whiteColor()
      // Do any additional setup after loading the view.
   }
   
   func tester(timer: NSTimer)
   {
      let theStringToPrint = timer.userInfo as String
      println(theStringToPrint)
   }
   
   
   @IBAction func start_read_USB(sender: AnyObject)
   {
      //myUSBController.startRead(1)
      teensy.start_read_USB()
      usb_read_OK = true
      
      //teensy.start_teensy_Timer()
      
      //     var somethingToPass = "It worked"
      
      //      let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tester:"), userInfo: somethingToPass, repeats: true)
      var timer : NSTimer? = nil
      timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("cont_read_USB:"), userInfo: nil, repeats: true)

   }
   
   func cont_read_USB(timer: NSTimer)
   {
      if (usb_read_OK)
      {
         if (teensy.new_Data)
         {
            let a1: UInt8 = teensy.last_read_byteArray[10]
            let a2: UInt8 = teensy.last_read_byteArray[11]
            
            let b1: Int32 = Int32(a1)
            let b2: Int32 = Int32(a2)
            
            H_Feld.intValue = b2
            L_Feld.intValue = b1
            
            let rotA:Int32 = b1 + (0xFF * b2)
            inputFeld.intValue = Int32(rotA)
            
            teensy.new_Data = false
         }
         
         
         
         
         //var tempbyteArray = [UInt8](count: 64, repeatedValue: 0x00)
         /*
         print("teensy read_byteArray: ")
         for  i in 0...16
         {
            print("| \(teensy.last_read_byteArray[i])")
         }
         println("|")
         */
         //println(teensy.read_byteArray)

         //println("tempbyteArray in Timer: *\(tempbyteArray)*")
         // var timerdic: [String: Int]
        
         /*
         if  var dic = timer.userInfo as? NSMutableDictionary
         {
            if var count:Int = timer.userInfo?["count"] as? Int
            {
               count = count + 1
               dic["count"] = count
               //dic["nr"] = count+2
               //println(dic)
            }
         }
        */
         
         //let timerdic:Dictionary<String,Int!> = timer.userInfo as Dictionary<String,Int!>
         //let messageString = userInfo["message"]
         //var tempcount = timerdic["count"]!
         
         //timer.userInfo["count"] = tempcount + 1
         
         
         
         
         
         //timerdic["count"] = 2
         
         // var count:Int = timerdic["count"]
         
         //timer.userInfo["count"] = count+1
         /*
         if !(teensy.last_read_byteArray == read_byteArray)
         {
            read_byteArray = last_read_byteArray
            
            print("+++ new read_byteArray in Timer:")
            for  i in 0...4
            {
               print(" \(read_byteArray[i])")
            }
            println()
            
            
         }
         */
         //println("*read_USB in Timer result: \(result)")
         
         //let theStringToPrint = timer.userInfo as String
         //println(theStringToPrint)
      }
      else
      {
         timer.invalidate()
      }
   }

   
   
   @IBAction func check_USB(sender: NSButton)
   {
      var erfolg = teensy.USBOpen()
      usbstatus = erfolg
      println("USBOpen erfolg: \(erfolg) usbstatus: \(usbstatus)")
      
      if (rawhid_status()==1)
      {
         println("status 1")
         USB_OK.backgroundColor = NSColor.greenColor()
         
         manufactorer.stringValue = "Manufactorer: " + teensy.manufactorer()!
      }
      else
         
      {
         println("status 0")
         USB_OK.backgroundColor = NSColor.redColor()
      }
      println("antwort: \(teensy.status())")
   }
   
   @IBAction func stop_read_USB(sender: AnyObject)
   {
      teensy.read_OK = false
      usb_read_OK = false
   }
   
   @IBAction func send_USB(sender: AnyObject)
   {
      //NSBeep()
      teensy.write_byteArray[0] = UInt8(codeFeld.intValue)
      teensy.write_byteArray[1] = UInt8(dataFeld.intValue)
      
      var c0 = codeFeld.intValue + 1
      codeFeld.intValue = c0
      var c1 = dataFeld.intValue + 1
      dataFeld.intValue = c1
      
      
      var senderfolg = teensy.send_USB()
      
      usb_read_OK = true
      
      //println("send_USB senderfolg: \(senderfolg)")
      
      
      /*
      var USB_Zugang = USBController()
      USB_Zugang.setKontrollIndex(5)
      
      Counter.intValue = USB_Zugang.kontrollIndex()
      
      // var  out  = 0
      
      //USB_Zugang.Alert("Hoppla")
      
      var x = getX()
      Counter.intValue = x
      
      var    out = rawhid_open(1, 0x16C0, 0x0480, 0xFFAB, 0x0200)
      
      println("send_USB out: \(out)")
      
      if (out <= 0)
      {
      usbstatus = 0
      inputFeld.stringValue = "not OK"
      println("kein USB-Device")
      }
      else
      {
      usbstatus = 1
      println("USB-Device da")
      var manu = get_manu()
      //println(manu) // ok, Zahl
      var manustring = UnsafePointer<CUnsignedChar>(manu)
      //println(manustring) // ok, Zahl
      
      let manufactorername = String.fromCString(UnsafePointer(manu))
      println("str: %s", manufactorername!)
      manufactorer.stringValue = manufactorername!
      
      /*
      var strA = ""
      strA.append(Character("d"))
      strA.append(UnicodeScalar("e"))
      println(strA)
      
      let x = manu
      let s = "manufactorer"
      println("The \(s) is \(manu)")
      var pi = 3.14159
      NSLog("PI: %.7f", pi)
      let avgTemp = 66.844322156
      println(NSString(format:"AAA: %.2f", avgTemp))
      */
      }
      */
      
      var timer : NSTimer? = nil
      timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("cont_write_USB:"), userInfo: nil, repeats: true)

   }
   
 func cont_write_USB(timer: NSTimer)
 {
    if (usb_read_OK)
    {
      NSBeep()
      teensy.write_byteArray[0] = UInt8(codeFeld.intValue)
      teensy.write_byteArray[1] = UInt8(dataFeld.intValue)
      
      var c0 = codeFeld.intValue + 1
      codeFeld.intValue = c0
      var c1 = dataFeld.intValue + 1
      dataFeld.intValue = c1
      
      var senderfolg = teensy.send_USB()

   }
    else
    {
      timer.invalidate()
   }

   }
   
   override var representedObject: AnyObject? {
      didSet {
         // Update the view, if already loaded.
      }
   }
   
   
}

