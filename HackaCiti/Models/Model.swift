//
//  Model.swift
//  HackaCiti
//
//  Created by Marcelo Araujo on 18/06/23.
//

import Foundation

struct OperacaoRemessaSimples: Codable, Hashable {
    let TipoOperacaoRemessa: String
    let CodigoServico: String
    let Bancos: String
    let DataGeracao: String
    let ValorTotal: String
    let StatusProjeto: String
}
