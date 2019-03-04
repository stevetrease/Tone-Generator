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
    var osc2 = AKOscillator()
    
    var mixer = AKMixer()
    
    var OCS1RotaryKnob: AKRotaryKnob!
    
    var OSC1FreqSlider: AKSlider!
    var OSC2FreqSlider: AKSlider!
    
    var OSC1waveform: AKPresetLoaderView!
    var OSC2waveform: AKPresetLoaderView!
    
    var button: AKButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        mixer = AKMixer (osc1, osc2)
        AudioKit.output = mixer
        try! AudioKit.start()
        
        osc1.amplitude = 0.5
        osc1.rampDuration = 0.1
        osc1.stop()
        
        osc2.amplitude = 0.5
        osc2.rampDuration = 0.1
        osc2.stop()
        
        setupUI()
    }
    
    
    func noteOn(note: MIDINoteNumber) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)", note.midiNoteToFrequency())
        print (osc1.frequency)
        osc1.start()
        osc2.start()
        // osc1.frequency = note.midiNoteToFrequency()
    }
    
    func noteOff(note: MIDINoteNumber) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        osc1.stop()
        osc2.stop()
    }
    
    
    
    func setupUI () {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let liveview = AKOutputWaveformPlot()
        stackView.addArrangedSubview(liveview)
    
        OSC1FreqSlider = AKSlider (property: "OSC1Freq", value: osc1.frequency, range: 10 ... 4000) { sliderValue in
            self.osc1.frequency = sliderValue
        }
        OSC1FreqSlider.onlyIntegers = true
        OSC1FreqSlider.textColor = .black
        stackView.addArrangedSubview(OSC1FreqSlider)
        
        // OCS1RotaryKnob = AKRotaryKnob (property: "OCS1RotaryKnob", value: osc2.frequency, range: 10 ... 4000) { sliderValue in
        //     self.osc2.frequency = sliderValue
        // }
        // stackView.addArrangedSubview(OCS1RotaryKnob)
        
        OSC2FreqSlider = AKSlider (property: "OSC2Freq", value: osc2.frequency, range: 10 ... 4000) { sliderValue in
            self.osc2.frequency = sliderValue
        }
        OSC2FreqSlider.onlyIntegers = true
        OSC2FreqSlider.textColor = .black
        stackView.addArrangedSubview(OSC2FreqSlider)
        
        button = AKButton (title: "Button") { press in
            print (press.title, "pressed")
        }
        stackView.addArrangedSubview(button)
        
        
        /*
        let waveforms = ["Sine", "Square", "Saw"]
        OSC1waveform = AKPresetLoaderView(presets: waveforms) { presets in
            switch presets {
            case "Sine":
                let x = 1
            case "Square":
                let y = 2
            case "Saw":
                let y = 3
            default:
                break
            }
        }
        stackView.addArrangedSubview(OSC1waveform)
        
        OSC2waveform = AKPresetLoaderView(presets: waveforms) { presets in
            switch presets {
            case "Sine":
                let x = 1
            case "Square":
                let y = 2
            case "Saw":
                let y = 3
            default:
                break
            }
        }
        stackView.addArrangedSubview(OSC2waveform)
        */
        
        
        
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

