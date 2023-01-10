//
//  NetworkClient.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation
import SVGKit

protocol NetworkClientInterface {
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping (Swift.Result<T, Error>) -> ())
    func fetchImageData(url: String, completion:@escaping (Swift.Result<Data, Error>) -> ())
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
    private let baseUrl: String
    private let imageBaseUrl: String
    let sessionDelegate: URLSessionDelegate?
    
    init(sessionDelegate: URLSessionDelegate? = nil) {
        self.baseUrl = Bundle.main.infoDictionary?["BaseURL"] as? String ?? ""
        self.imageBaseUrl = Bundle.main.infoDictionary?["ImageBaseURL"] as? String ?? ""
        
        self.sessionDelegate = sessionDelegate
    }
    
    // MARK :- Fetch Data from API.
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping (Swift.Result<T, Error>) -> ()) {
        guard let url = URL(string: (self.baseUrl + url)) else { return }
        let session = URLSession(configuration: .default, delegate: self.sessionDelegate, delegateQueue: nil)
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error { completion(.failure(error)) }
                return }
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(serverData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK :- Fetch Image Data from image API.
    func fetchImageData(url: String, completion:@escaping (Swift.Result<Data, Error>) -> ()) {
        guard let url = URL(string: (self.imageBaseUrl + url)) else { return }
        let session = URLSession(configuration: .default, delegate: self.sessionDelegate, delegateQueue: nil)
        session.dataTask(with: url) { (data, response, error) in
            guard let imageData = data else {
                if let error = error { completion(.failure(error)) }
                return
            }
            let receivedicon: SVGKImage = SVGKImage(data: imageData)
            
            if let image = receivedicon.uiImage,
                let pngImageData =  image.pngData() {
                completion(.success(pngImageData))
            } else {
                completion(.success(imageData))
            }
        }.resume()
    }
}
