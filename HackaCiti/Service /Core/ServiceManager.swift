//
//  ServiceManager.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//


import Foundation

// Enum para os erros que podem ocorrer na chamada da API
enum APIError: Error {
    case invalidURL
    case apiError(cause: Error)
    case invalidResponse
}

// Protocolo para gerenciar chamadas de API
protocol APIServiceManager {
    // Chamadas de API genéricas, cada uma pode ter um tipo de resposta diferente
    func fetch<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void)
    func post<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void)
    func delete<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void)
    func put<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void)
}

// Protocolo para decodificação da resposta
protocol ResponseDecoder {
    // Decodifica um objeto genérico do tipo Decodable a partir dos dados recebidos
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

// Implementação padrão do protocolo de decodificação
struct DefaultResponseDecoder: ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}

// Implementação padrão do gerenciador de serviços de API
class DefaultAPIServiceManager: APIServiceManager {
    private let session: NetworkSession
    private let decoder: ResponseDecoder

    init(session: NetworkSession = URLSession.shared, decoder: ResponseDecoder = DefaultResponseDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    // Método de execução de solicitações de API genéricas
    private func performRequest<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        guard let url = request.url else {
            print("API Error: Invalid URL")
            return completion(.failure(.invalidURL))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        if request.method != "GET" {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = request.body
        
        print("Performing \(request.method) request to \(url)")
        
        // Carregando dados a partir da URL da solicitação
        session.loadData(from: urlRequest) { data, error in
            if let error = error {
                print("API Error: \(error)")
                return completion(.failure(.apiError(cause: error)))
            }
            
            if let data = data {
                do {
                    // Decodificando os dados em um objeto genérico
                    let model = try self.decoder.decode(T.ResponseType.self, from: data)
                    completion(.success(model))
                } catch {
                    // Tratando erros de decodificação
                    print("Decoding error for type \(T.ResponseType.self): ", error)
                    completion(.failure(.invalidResponse))
                }
            } else {
                print("API Error: Invalid response")
                completion(.failure(.invalidResponse))
            }
        }
    }


    // Implementação de cada tipo de chamada de API
    func fetch<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        performRequest(request: request, completion: completion)
    }
    
    func post<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        performRequest(request: request, completion: completion)
    }

    func delete<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        performRequest(request: request, completion: completion)
    }
    
    func put<T: APIRequest>(request: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void) {
        performRequest(request: request, completion: completion)
    }
}

