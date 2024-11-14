//
//  ViewController.swift
//  unsplash
//
//  Created by Nursultan Turekulov on 10.11.2024.
//

import UIKit

class ViewController: UIViewController {
    var manager = UnsplashManager()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        layout.minimumInteritemSpacing = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    var dataSource: [UnsplashData] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .white
        manager.delegate = self
        manager.performRequest()
        view.addSubview(collectionView)
        addConstraints()
        
        // Do any additional setup after loading the view.
    }
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    func getImage(_ url: String, completion: @escaping (UIImage?) -> Void){
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completion(image) // Return the image in the main thread
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil) // Return nil if there was an error
                        }
                    }
                }.resume()
        }
       
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else{
            fatalError("ooops something wrong in collection view")
        }
        getImage(dataSource[indexPath.row].urls.thumb) { image in
            if let imageCell = image {
                cell.configureCell(imageCell)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}

extension ViewController: UnsplashManagerDelegate {
    func updateArray(unsplashManager: UnsplashManager, data: [UnsplashData]) {
        DispatchQueue.main.async {
            self.dataSource = data
            self.collectionView.reloadData()
        }
    }
}
