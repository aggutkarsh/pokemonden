//
//  NetworkClient.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation
import SVGKit

protocol NetworkClientInterface {
    func fetchPokemonList<T: Decodable>(model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ())
    func fetchPokemonDetails<T: Decodable>(id: Int, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ())
    func fetchPokemonDesc<T: Decodable>(id: Int, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ())
    func fetchPokemonImage(id: Int, completion:@escaping(Data) -> (), failure:@escaping(Error) -> ())
}

class SSLPinningManager: NSObject, URLSessionDelegate {
    var isSSLPinningEnabled = false
    
    init(isSSLPinningEnabled: Bool = false){
        self.isSSLPinningEnabled = isSSLPinningEnabled
    }
    
    //MARK :- UrlSession Delegate.
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.serverTrust == nil {
            completionHandler(.useCredential, nil)
        } else {
            let trust: SecTrust = challenge.protectionSpace.serverTrust!
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        }
    }
}

class RESTClient: NetworkClientInterface {
    let baseUrl: String
    let imageBaseUrl: String
    
    init() {
        self.baseUrl = Bundle.main.infoDictionary?["BaseURL"] as? String ?? ""
        self.imageBaseUrl = Bundle.main.infoDictionary?["ImageBaseURL"] as? String ?? ""
    }
    
    func fetchPokemonList<T: Decodable>(model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        guard let url = URL(string: (self.baseUrl + "pokemon")) else { return }
        fetchData(url: url, model: model, completion: completion, failure: failure)
    }
    
    func fetchPokemonDetails<T: Decodable>(id: Int, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        guard let url = URL(string: (self.baseUrl + "pokemon/\(id)/")) else { return }
        fetchData(url: url, model: model, completion: completion, failure: failure)
    }
    
    func fetchPokemonDesc<T: Decodable>(id: Int, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        guard let url = URL(string: (self.baseUrl + "pokemon-species/\(id)")) else { return }
        fetchData(url: url, model: model, completion: completion, failure: failure)
    }
    
    // MARK :- Fetch Data from API.
    func fetchData<T: Decodable>(url: URL, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        let session = URLSession(configuration: .default, delegate: SSLPinningManager(isSSLPinningEnabled: true), delegateQueue: nil)
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error { failure(error) }
                return }
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }.resume()
    }
    
    func fetchPokemonImage(id: Int, completion:@escaping(Data) -> (), failure:@escaping(Error) -> ()) {
        let url = String(format:"sprites/master/sprites/pokemon/other/dream-world/%d.svg", id)
        guard let url = URL(string: (self.imageBaseUrl + url)) else { return }
        fetchImageData(url: url, completion: completion, failure: failure)
    }
    
    // MARK :- Fetch Image Data from image API.
    func fetchImageData(url: URL, completion:@escaping(Data) -> (), failure:@escaping(Error) -> ()) {
        let session = URLSession(configuration: .default, delegate: SSLPinningManager(isSSLPinningEnabled: true), delegateQueue: nil)
        session.dataTask(with: url) { (data, response, error) in
            guard let imageData = data else {
                if let error = error { failure(error) }
                return
            }
            let receivedicon: SVGKImage = SVGKImage(data: imageData)
            
            if let image = receivedicon.uiImage,
                let pngImageData =  image.pngData() {
                completion(pngImageData)
            } else {
                completion(imageData)
            }
        }.resume()
    }
}
