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
    var oscillator2 = AKOscillator()
    var mixer = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mixer = AKMixer(oscillator1, oscillator2)
        mixer.volume = 0.5
        AudioKit.output = mixer
        
        AKSettings.playbackWhileMuted = true
        
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit did not start!")
        }
        
        
        oscillator1.amplitude = random(in: 0.5...1.0)
        oscillator1.frequency = random(in: 220...880)
        print (oscillator1.amplitude, oscillator1.frequency)
        oscillator1.start()

    }


}

