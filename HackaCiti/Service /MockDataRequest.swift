//
//  MockDataRequest.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import Foundation

struct MockDataRequest: APIRequest {
    typealias ResponseType = [OperacaoRemessaSimples]
    
    var baseURL: URL { return URL(string: "http://localhost:3001")! }
    var path: String { return "/mockData" }
    var method: String { return "GET" }
    var body: Data? { return nil }
}
