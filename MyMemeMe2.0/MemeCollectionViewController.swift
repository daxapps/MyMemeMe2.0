//
//  MemeCollectionViewController.swift
//  MyMemeMe2.0
//
//  Created by Jason Crawford on 11/2/16.
//  Copyright © 2016 Jason Crawford. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        changeFlowLayout(UIDevice.current.orientation)
        self.edgesForExtendedLayout = UIRectEdge()
        updateMemes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMemes()
        collectionView.reloadData()
        changeFlowLayout(UIDevice.current.orientation)
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        changeFlowLayout(UIDevice.current.orientation)
    }
    
    func changeFlowLayout(_ orientation: UIDeviceOrientation) {
        
        let space: CGFloat = 3.0
        let dimension = orientation.isPortrait
            ? (self.view.frame.size.width - (2 * space)) / 3
            : (self.view.frame.size.width - (4 * space)) / 5
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func updateMemes(){
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.memeImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    @IBAction func createMeme(_ sender: UIBarButtonItem) {
        presentMemeEditor()
    }
    
    func presentMemeEditor() {
        let memeEditorController = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        self.present(memeEditorController, animated: true, completion: nil)
    }

}
