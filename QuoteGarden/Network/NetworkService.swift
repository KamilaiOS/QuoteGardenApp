//
//  Service.swift
//  AppleStore
//
//  Created by Kamila Lech on 26/09/2019.

import Foundation

protocol NetworkManager {
    func fetchRequest<T: Codable> (urlString: String,
                                   httpMethod: HTTPMethod,
                                   json: [String: Any]?,
                                   completion: @escaping (Result<T, Error>) -> Void)
}

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum APIError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
    case responseDataError
}

class NetworkService: NetworkManager {
    private static func checkErrorCode(_ errorCode: Int) -> APIError {
        switch errorCode {
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
            // Add morr according to your requirments
        default:
            return .unknownError
        }
    }
    func fetchRequest<T: Codable> (urlString: String,
                                   httpMethod: HTTPMethod,
                                   json: [String: Any]?,
                                   completion: @escaping (Result<T, Error>) -> Void) {
         NSLog(#function + " 🔵 🔵 🔵 URL:\(urlString), \n parameters: \(String(describing: json)) \n 🔵 🔵 🔵")
        // Create Request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("eR5XtJNNLoTYZCED10euqvOQ4ooRhr08", forHTTPHeaderField: "apikey")
        
        
        if let postJson = json {
            // HTTP Headers
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
  
            let jsonData = try? JSONSerialization.data(withJSONObject: postJson)
            request.httpBody = jsonData
        }
        // Create URLSession instance
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        session.dataTask(with: request) {(data, resp, err) in
            // Http Status Code
            if let statusCode = resp?.getStatusCode() {
                print("Http Status Code: \(statusCode)")
            }
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.responseDataError))
                return
            }
            /* Debug Data
             NSLog(#function + " 🔵 Output Raw Data Size \(urlString): \(data)")
             let outputDataStr  = String(data: data, encoding: String.Encoding.utf8) as String?
             NSLog(#function + " 🔵 Output String:\(String(describing: outputDataStr))")
             */
            do {
                let parsedObj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(parsedObj))
            } catch let jsonErr {
                print("🔴 Failed to decode json:", jsonErr)
                completion(.failure(jsonErr))
            }
        }.resume()
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
