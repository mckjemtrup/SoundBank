//
//  addSoundViewController.swift
//  SoundBank
//
//  Created by Michael Kjemtrup on 07/03/2017.
//  Copyright © 2017 Michael Kjemtrup. All rights reserved.
//

import UIKit
import AVFoundation

class addSoundViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder :  AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    func setupRecorder() {
        do{
            //Create an audiosession
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker )
            try session.setActive(true)
            
            
            //Create URL for audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("#####################")
            print(audioURL)
            
            
            //Create settings for audiorecorder
            var settings : [String : AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            
            
            //Create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
            
            
        } catch let error as NSError  {
            print(error)
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            //Stop recording
            
            audioRecorder?.stop()
            
            //Change button title to record
            
            recordButton.setTitle("Record", for: .normal)
           
        } else {
            //Start Recording
            
            audioRecorder?.record()
            
            //Change button title to stop recording
            
            recordButton.setTitle("Stop recording", for: .normal)
          
            
        }
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
    
    
}
