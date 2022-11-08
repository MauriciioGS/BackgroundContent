//
//  CharacterDataManager.swift
//  BackgroundContent
//
//  Created by Proteco on 29/10/22.
//

import UIKit

class CharacterDataManager{
    
    private var characters = [Results]()
    
    enum CharacterDataManagerError: Error {
        case invalidURL
        case missingData
    }

    func fetchCharacters(completion: @escaping (Result<Bool, Error>) -> Void){
        let configuracion = URLSessionConfiguration.default
        let session = URLSession(configuration: configuracion)
        // Do any additional setup after loading the view.
        guard let url=URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(CharacterDataManagerError.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let tarea = session.dataTask(with: request){ datos, response, error in
            if let error = error {
                print("Algo salió mal \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let bytes = datos else {
                print("El response no trajo datos")
                completion(.failure(CharacterDataManagerError.missingData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Character.self, from: bytes)
                self.characters = response.results
                completion(.success(true))
            } catch {
                print("Error al decodificar \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        tarea.resume()
    }

    func characterCount() -> Int {
        return characters.count
    }

    func characterAtIndex(index: Int) -> Results{
        return characters[index]
    }
    
}
