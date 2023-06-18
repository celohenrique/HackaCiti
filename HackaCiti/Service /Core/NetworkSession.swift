//
//  NetworkSession.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import Foundation

// Protocolo para gerenciar sessões de rede
protocol NetworkSession: AnyObject {
    // Carrega dados a partir de uma URLRequest e executa o bloco de conclusão com os dados ou erro resultante
    func loadData(from url: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

// Estende URLSession para aderir ao protocolo NetworkSession
extension URLSession: NetworkSession {
    func loadData(from url: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        // Inicia uma tarefa de rede para carregar dados a partir de uma URLRequest e, ao terminar, executa o bloco de conclusão
        let task = dataTask(with: url, completionHandler: { data, _, error in
            completionHandler(data, error)
        })
        task.resume()
    }
}
