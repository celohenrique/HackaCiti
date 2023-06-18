//
//  ContentView.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var data = [OperacaoRemessaSimples]()
    
    var body: some View {
        VStack(alignment: .center){
            Text("Contingência").font(.largeTitle)
        }
        List(data, id: \.TipoOperacaoRemessa) { item in
            VStack(alignment: .leading) {
                Text(item.Bancos)
                    .font(.headline)
                Text("Valor total: R$ \(item.ValorTotal)")
                    .font(.subheadline)
                Text("Status do projeto: \(item.StatusProjeto)")
                    .font(.subheadline)
                Text("Data da geração: \(item.DataGeracao)")
                    .font(.subheadline)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let request = MockDataRequest()
        let serviceManager = DefaultAPIServiceManager()
        serviceManager.fetch(request: request) { result in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
