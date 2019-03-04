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





class ViewController: UIViewController, AKKeyboardDelegate  {

    var osc1 = AKOscillator()
    var mixer = AKMixer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        mixer = AKMixer (osc1)
        AudioKit.output = mixer
        try! AudioKit.start()
        
        osc1.amplitude = 0.5
        osc1.rampDuration = 0.1
        osc1.stop()
        
        setupUI()
    }
    
    
    func noteOn(note: MIDINoteNumber) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        osc1.start()
        osc1.frequency = note.midiNoteToFrequency()
        print (osc1.frequency)
    }
    
    func noteOff(note: MIDINoteNumber) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        osc1.stop()
    }
    
    
    
    func setupUI () {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let liveview = AKOutputWaveformPlot()
        stackView.addArrangedSubview(liveview)
    
        
        let keyboardView = AKKeyboardView()
        keyboardView.delegate = self
        stackView.addArrangedSubview(keyboardView)
        
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
        
}

