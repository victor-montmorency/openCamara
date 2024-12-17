//
//  model.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//


import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let dados: [Dado]
    let links: [Link]
}

// MARK: - Dado
struct Dado: Codable {
    let id: Int
    let uri: String
    let nome: String
    let siglaPartido: SiglaPartido
    let uriPartido: String
    let siglaUf: String
    let idLegislatura: Int
    let urlFoto: String
    let email: String
}

enum SiglaPartido: String, Codable {
    case avante = "AVANTE"
    case cidadania = "CIDADANIA"
    case mdb = "MDB"
    case novo = "NOVO"
    case pCdoB = "PCdoB"
    case pdt = "PDT"
    case pl = "PL"
    case pode = "PODE"
    case pp = "PP"
    case prd = "PRD"
    case psb = "PSB"
    case psd = "PSD"
    case psdb = "PSDB"
    case psol = "PSOL"
    case pt = "PT"
    case pv = "PV"
    case rede = "REDE"
    case republicanos = "REPUBLICANOS"
    case sPart = "S.PART."
    case solidariedade = "SOLIDARIEDADE"
    case união = "UNIÃO"
}

// MARK: - Link
struct Link: Codable {
    let rel: String
    let href: String
}
