//
//  NoteViewController.swift
//  Notes
//
//  Created by Brenno Natal on 14/12/20.
//

import UIKit

class NoteViewController: UIViewController {
    var note: Note!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note.contents
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.contents = textView.text
        NoteManager.main.save(note: note)
    }
}
