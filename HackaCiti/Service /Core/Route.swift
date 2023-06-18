//
//  Route.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import Foundation

// Protocolo para descrever uma requisição para a API
protocol APIRequest {
    // Define o tipo que será decodificado a partir da resposta da API
    associatedtype ResponseType: Decodable
    
    // A URL base da API
    var baseURL: URL { get }
    // O caminho para o endpoint específico da API
    var path: String { get }
    // O método HTTP a ser usado (GET, POST, etc.)
    var method: String { get }
    // O corpo da requisição, se houver
    var body: Data? { get }
}

// Estende APIRequest com uma propriedade para construir a URL completa do endpoint
extension APIRequest {
    // Combina a URL base com o caminho para formar a URL completa
    var url: URL? {
        return URL(string: "\(baseURL.absoluteString)\(path)")
    }
}
