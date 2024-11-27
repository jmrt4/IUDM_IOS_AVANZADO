//
//  ViewController.swift
//  GameLibrary
//
//  Created by Master Moviles on 23/11/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var games: [Game] = [
        Game(title: "prueba1", coverImage: "", description: "descripcion1", developer: "nombre1", status: "Pendientes", category: Category.ACTION),
        Game(title: "prueba2", coverImage: "", description: "descripcion2", developer: "nombre2", status: "Jugando", category: Category.ADVENTURE),
        Game(title: "prueba3", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Completados", category: Category.SHOOTER),
        Game(title: "prueba4", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER),
        Game(title: "prueba5", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER),
        Game(title: "prueba6", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER),
        Game(title: "prueba7", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER),
        Game(title: "prueba8", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER),
        Game(title: "prueba9", coverImage: "", description: "descripcion3", developer: "nombre3", status: "Pendientes", category: Category.SHOOTER)
    ]
    
    let status = ["Pendientes", "Jugando", "Completados"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "Mi Biblioteca"
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 140)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return status.count
    }
    
    func filteredGames(forSection section: Int)  -> [Game] {
        return games.filter { $0.status == status[section] }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredGames(forSection: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = filteredGames(forSection: indexPath.section)[indexPath.item]
        cell.configure(with: game)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeader
        headerView.titleLabel.text = status[indexPath.section]
        
        return headerView
    }
}

