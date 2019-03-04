//
//  ViewController.swift
//  Tone Generator
//
//  Created by Steve on 04/03/2019.
//  Copyright © 2019 Steve. All rights reserved.
//

import UIKit

import AudioKit
import AudioKitUI



class ViewController: UIViewController {

    var oscillator1 = AKOscillator()
    var mixer = AKMixer()
    
    
    @IBOutlet weak var OSC1Switch: UISwitch!
    @IBOutlet weak var OSC1Waveform: UISegmentedControl!
    @IBOutlet weak var OSC1Frequency: UIStepper!
    @IBOutlet weak var OSC1FrequencyLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        mixer = AKMixer(oscillator1)
        mixer.volume = 0.5
        AudioKit.output = mixer
        
        oscillator1.amplitude = 0.5
        oscillator1.rampDuration = 0.1
        // oscillator1.frequency = OSC1Frequency.value
        // oscillator1.start()
        
        AKSettings.playbackWhileMuted = true
        
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit did not start!")
        }
        
        updateOSC1()
    }
    
    
    @IBAction func OSC1changed (sender: AnyObject) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        updateOSC1()
    }
    
    func updateOSC1() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        oscillator1.frequency = OSC1Frequency.value
        OSC1FrequencyLabel.text = formatter.string(from: NSNumber(value: oscillator1.frequency))
        
        if OSC1Switch.isOn {
            oscillator1.start()
        } else {
            oscillator1.stop()
        }
        
        
        
        
        print (oscillator1.amplitude, oscillator1.frequency, oscillator1.isStarted)
    }

}

