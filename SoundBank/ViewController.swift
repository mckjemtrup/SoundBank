 //
 //  ViewController.swift
 //  SoundBank
 //
 //  Created by Michael Kjemtrup on 07/03/2017.
 //  Copyright © 2017 Michael Kjemtrup. All rights reserved.
 //
 
 import UIKit
 import AVFoundation
 
 class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var soundTableView: UITableView!
    var audioPlayer : AVAudioPlayer?
    
    var sounds : [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        soundTableView.dataSource = self
        soundTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let contexting = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            sounds = try contexting.fetch(Sound.fetchRequest())
            soundTableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell ()
        
        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sounding = sounds[indexPath.row]
        do{
            audioPlayer = try AVAudioPlayer(data: sounding.audio! as Data )
            audioPlayer?.play()
        } catch let error as NSError  {
            print(error)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Hello Delete Me Pls")
            let sounding = sounds[indexPath.row]
            let contexting = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            contexting.delete(sounding)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                sounds = try contexting.fetch(Sound.fetchRequest())
                soundTableView.reloadData()
            } catch {}
        }
    }
 }
 
