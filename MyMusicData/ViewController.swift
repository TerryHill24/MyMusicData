//
//  ViewController.swift
//  MyMusicData
//
//  Created by RVC Terry on 10/16/20.
//  Copyright © 2020 RVC Terry. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var artist: UITextField!
    @IBOutlet weak var songtitle: UITextField!
    @IBOutlet weak var album: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //0a Edit contact
        artist.isEnabled = true
        songtitle.isEnabled = true
        album.isEnabled = true
        year.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        artist.becomeFirstResponder()
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        //1 Add Save Logic
        if (contactdb != nil)
        {
            
            contactdb.setValue(artist.text, forKey: "artist")
            contactdb.setValue(songtitle.text, forKey: "songtitle")
            contactdb.setValue(album.text, forKey: "album")
            contactdb.setValue(year.text, forKey: "year")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Song",in: managedObjectContext)
            
            let contact = Song(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            contact.artist = artist.text!
            contact.songtitle = songtitle.text!
            contact.album = album.text!
            contact.year = year.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if error != nil {
            //if error occurs
            // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        //2) Dismiss ViewController
        self.dismiss(animated: true, completion: nil)
        //       let detailVC = ContactTableViewController()
        //        detailVC.modalPresentationStyle = .fullScreen
        //        present(detailVC, animated: false)
    }
    
    
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //4) Add variable contactdb (used from UITableView
    var contactdb:NSManagedObject!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        if (contactdb != nil)
        {
            artist.text = contactdb.value(forKey: "artist") as? String
            songtitle.text = contactdb.value(forKey: "songtitle") as? String
            album.text = contactdb.value(forKey: "album") as? String
            year.text = contactdb.value(forKey: "year") as? String
            
            btnSave.setTitle("Update", for: UIControl.State())
            
            btnEdit.isHidden = false
            artist.isEnabled = false
            songtitle.isEnabled = false
            album.isEnabled = false
            year.isEnabled = false
            btnSave.isHidden = true
        }else{
            
            btnEdit.isHidden = true
            artist.isEnabled = true
            songtitle.isEnabled = true
            album.isEnabled = true
            year.isEnabled = true
        }
        artist.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //6 Add to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }
    
    //7 Add to hide keyboard
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        artist.endEditing(true)
        songtitle.endEditing(true)
        album.endEditing(true)
        year.endEditing(true)
        
    }
    
    //8 Add to hide keyboard
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }


}

