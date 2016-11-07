//
//  MemeViewController.swift
//  MyMemeMe2.0
//
//  Created by Jason Crawford on 11/2/16.
//  Copyright © 2016 Jason Crawford. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editMeme(_:))
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView!.image = meme.memeImage
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController!.tabBar.isHidden = true
    }
    
    func editMeme(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editSegue", sender: nil)
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeEditorController = segue.destination as! MemeEditorViewController
        memeEditorController.meme = meme
    }

}
