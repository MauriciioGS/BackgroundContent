//
//  ViewController.swift
//  BackgroundContent
//
//  Created by Proteco on 29/10/22.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var charactersTableView: UITableView!
    
    private var personajes = [Results]()
    let characterDataManager = CharacterDataManager()
    private var selectedCharacter : Results!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterDataManager.characterCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: "personajeCell", for: indexPath) as! CharacterViewCell
        cell.setup(with: characterDataManager.characterAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = characterDataManager.characterAtIndex(index: indexPath.row)
        print(selectedCharacter.name)
        self.performSegue(withIdentifier: "characterInfo", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ShowCharacterViewcontroller
        destination.reciviedCharacter = selectedCharacter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
        characterDataManager.fetchCharacters() { [unowned self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    charactersTableView.reloadData()
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let configuracion = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuracion)
//
//        if let laURL = URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/halloween_sun_2014.jpeg"){
//            let request = URLRequest(url: laURL)
//            let tarea = session.dataTask(with: request){ datos, response, error in
//                if let _ = error {
//                    print("Algo salió mal \(error?.localizedDescription ?? "")")
//                    return
//                }
//                guard let bytes = datos else {
//                    print("El response no trajo datos")
//                    return
//                }
//
//                // Para cualquier cambiio a la UI, este debe ser en el main thread
//                DispatchQueue.main.async {
//                    let imageView = UIImageView(frame: self.view.frame)
//                    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                    imageView.image = UIImage(data: bytes)
//                    self.view.addSubview(imageView)
//                }
//            }
//            tarea.resume()
//        }
        
    }
    
}
