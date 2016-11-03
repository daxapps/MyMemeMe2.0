//
//  MemeTableViewController.swift
//  MyMemeMe2.0
//
//  Created by Jason Crawford on 11/2/16.
//  Copyright © 2016 Jason Crawford. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        updateMemes()
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMemes()
        tableView.reloadData()
    }
    
    func updateMemes(){
        memes=(UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MemeTableViewCellController = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as! MemeTableViewCellController
        
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeImageView?.image=meme.memeImage
        cell.memeLabel?.text=meme.topText!+"..."+meme.bottomTextString!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        let destination = segue.destination as! MemeViewController
        let index = sender as! IndexPath
        
        destination.meme = memes[(index as NSIndexPath).row]
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            memes.remove(at: (indexPath as NSIndexPath).row)
            (UIApplication.shared.delegate as! AppDelegate).memes=memes
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func createMeme(_ sender: UIBarButtonItem) {
        presentMemeEditor()
    }
    
    func presentMemeEditor() {
        let memeEditorController = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        self.present(memeEditorController, animated: true, completion: nil)
    }

}
