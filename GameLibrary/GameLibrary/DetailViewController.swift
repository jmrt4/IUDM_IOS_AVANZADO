//
//  DetailViewController.swift
//  GameLibrary
//
//  Created by Master Moviles on 29/11/24.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var developerLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        title = "Detalle del juego"
        view.backgroundColor = .systemBackground
        titleLable.text = game?.title
        developerLabel.text = game?.developer
        categoryLabel.text = game?.category
        descriptionTextView.text = game?.description
        
        coverImage.contentMode = .scaleAspectFit
        coverImage.layer.cornerRadius = 8
        coverImage.clipsToBounds = true
        coverImage.image = UIImage(systemName: "photo")
        
        titleLable.textAlignment = .center
        developerLabel.textAlignment = .center
        categoryLabel.textAlignment = .center
        descriptionTextView.textAlignment = .justified
        
        NSLayoutConstraint.activate([
            coverImage.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
        
        guard let url = URL(string: game!.coverImage) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.coverImage.image = image
            }
        }.resume()
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
