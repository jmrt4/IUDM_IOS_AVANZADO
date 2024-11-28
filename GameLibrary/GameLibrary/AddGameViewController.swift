//
//  AddGameViewController.swift
//  GameLibrary
//
//  Created by Master Moviles on 27/11/24.
//

import UIKit

class AddGameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var textGame: UITextField!
    @IBOutlet var textDeveloper: UITextField!
    @IBOutlet var imageCover: UITextField!
    @IBOutlet var textDescription: UITextField!
    @IBOutlet var categoryGame: UIPickerView!
    @IBOutlet var statusSelector: UIButton!
    
    let status = ["Pendientes", "Jugando", "Completados"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Añadir Juego"
        
        categoryGame.delegate = self
        categoryGame.dataSource = self
        
        let actionPending = UIAction(title: status[0]) {_ in }
        let actionCurrent = UIAction(title: status[1]) {_ in }
        let actionComplete = UIAction(title: status[2]) {_ in }
        
        statusSelector.menu = UIMenu(title: "Estado", children: [actionPending,actionCurrent,actionComplete])
        statusSelector.showsMenuAsPrimaryAction = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    @IBAction func addNewGame(_ sender: Any) {
        guard let title = textGame.text, !title.isEmpty,
              let developer = textDeveloper.text, !developer.isEmpty,
              let cover = imageCover.text, !cover.isEmpty,
              let description = textDescription.text, !description.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let newGame = Game(title: title, coverImage: cover, description: description, developer: developer, status: statusSelector.currentTitle!, category: Category.allCases[categoryGame.selectedRow(inComponent: 0)])
        
        var gameManager = GameManager()
        
        var games = gameManager.loadGames()
        games.append(newGame)
        gameManager.saveGames(games)
        
        navigationController?.popViewController(animated: true)
    }

}
