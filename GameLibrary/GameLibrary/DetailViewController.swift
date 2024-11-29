//
//  DetailViewController.swift
//  GameLibrary
//
//  Created by Master Moviles on 29/11/24.
//

import UIKit

class DetailViewController: UIViewController {

    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        title = "Detalle del juego"
        view.backgroundColor = .systemBackground
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
