//
//  ContentView.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State var data = [OperacaoRemessaSimples]()
    
    var processados: Float {
        return data.filter { $0.StatusProjeto == "Processado" }.reduce(0) { $0 + (Float($1.ValorTotal) ?? 0) }
    }
    
    var reprocessando: Float {
        return data.filter { $0.StatusProjeto == "Reprocessado" }.reduce(0) { $0 + (Float($1.ValorTotal) ?? 0) }
    }
    
    var processando: Float {
        return data.filter { $0.StatusProjeto == "Processando" }.reduce(0) { $0 + (Float($1.ValorTotal) ?? 0) }
    }
    
    var quantidadeProcessados: Int {
        return data.filter { $0.StatusProjeto == "Processado" }.count
    }
    
    var quantidadeReprocessando: Int {
        return data.filter { $0.StatusProjeto == "Reprocessado" }.count
    }
    
    var quantidadeProcessando: Int {
        return data.filter { $0.StatusProjeto == "Processando" }.count
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text("Contingência").font(.largeTitle)
            HStack {
                VStack {
                    Text("Processados").font(.headline)
                    Text("Valor Total: R$ \(processados)")
                    Text("Quantidade: \(quantidadeProcessados)")
                }
                VStack {
                    Text("Reprocessando").font(.headline)
                    Text("Valor Total: R$ \(reprocessando)")
                    Text("Quantidade: \(quantidadeReprocessando)")
                }
                VStack {
                    Text("Processando").font(.headline)
                    Text("Valor Total: R$ \(processando)")
                    Text("Quantidade: \(quantidadeProcessando)")
                }
            }
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
