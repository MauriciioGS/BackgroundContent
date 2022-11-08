//
//  ShowCharacterViewcontroller.swift
//  BackgroundContent
//
//  Created by Proteco on 29/10/22.
//

import UIKit

class ShowCharacterViewcontroller: UIViewController{
    
    @IBOutlet weak var imageCharacter: UIImageView!
    var reciviedCharacter: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp(){
        let configuracion = URLSessionConfiguration.default
        let session = URLSession(configuration: configuracion)
        
        if let laURL = URL(string: reciviedCharacter.image){
            let request = URLRequest(url: laURL)
            let tarea = session.dataTask(with: request){ datos, response, error in
                if let error = error {
                    print("Algo salió mal \(error.localizedDescription)")
                    return
                }
                guard let bytes = datos else {
                    print("El response no trajo datos")
                    return
                }
                
                // Para cualquier cambiio a la UI, este debe ser en el main thread
                DispatchQueue.main.async {
                    self.imageCharacter.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    self.imageCharacter.image = UIImage(data: bytes)
                }
            }
            tarea.resume()
        }
    }
}
