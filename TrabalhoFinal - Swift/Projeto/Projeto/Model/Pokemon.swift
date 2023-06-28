//
//  Pokemon.swift
//  Projeto
//
//  Created by Afonso Januario on 27/06/2023.
//

import Foundation
import SwiftUI

// Estrutura Pokemon
struct Pokemon: Identifiable, Decodable {
    var isFavourite = false // Indica se o Pokémon é favorito
    
    let id: Int // ID do Pokémon
    let name: String // Nome do Pokémon
    let imageURL: String // URL da imagem do Pokémon
    let type: String // Tipo do Pokémon
    let description: String // Descrição do Pokémon
    
    let attack: Int // Valor de ataque do Pokémon
    let defense: Int // Valor de defesa do Pokémon
    let height: Int // Altura do Pokémon
    let weight: Int // Peso do Pokémon
    
    // Chaves para descodificar os atributos do JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
        case attack
        case defense
        case height
        case weight
    }
    
    // Devolve a cor correspondente do tipo Pokémon
    var typeColor: Color {
        switch type {
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemGreen)
        case "water":
            return Color(.systemTeal)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "normal":
            return Color(.systemOrange)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemBlue)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
}
