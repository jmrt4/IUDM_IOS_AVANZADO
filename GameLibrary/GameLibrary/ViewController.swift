//
//  ViewController.swift
//  GameLibrary
//
//  Created by Master Moviles on 23/11/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var addGameButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var games: [Game] = []
    
    private let gameManager = GameManager()
    
    let status = ["Pendientes", "Jugando", "Completados"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = gameManager.loadGames()
        setupUI()
        addGameButton.layer.cornerRadius = addGameButton.frame.size.width / 2
        view.bringSubviewToFront(addGameButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 50)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
        collectionView.addGestureRecognizer(tapGesture)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc func handleCellTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: location) {
            let selectedGame = filteredGames(forSection: indexPath.section)[indexPath.item]
            
            let datailStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailViewController.game = selectedGame
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
}

