//
//  PokemonViewModel.swift
//  Projeto
//
//  Created by Afonso Januario on 07/06/2023.
//

import Foundation

// Possíveis erros durante a chamada dos dados do Pokémon da API
enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}

class PokemonViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]() // Array de Pokémon
    
    init() {
        
        // Executa a função para obter os dados dos Pokémons de forma assíncrona
        Task {
            do {
                pokemon = try await getPokemon()
            } catch {
                print("Ocorreu um erro ao obter o Pokémon: \(error)")
            }
        }
    }
    
    // Função para obter os pokémons
    func getPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json")
        else {
            // Lança o erro FetchError.badURL se o URL for inválido
            throw FetchError.badURL
        }
        
        // Cria uma URLRequest utilizando a URL válida obtida anteriormente
        let urlRequest = URLRequest(url: url)
        // Faz uma requisição assíncrona para obter os dados da URL usando a URLSession.shared
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Remove "null," dos dados e atribui o resultado à constante 'data'
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }
        // Verifica se o código de status da resposta HTTP é 200 (OK)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        // Descodifica os dados JSON para um array de objetos do tipo Pokemon
        let maybePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return maybePokemonData
    }
    // Pokémon de teste
    let MOCK_POKEMON = Pokemon(id: 0, name: "Bulbasaur", imageURL: "https://firebasestorage.googleapis.co...", type: "poison", description: "This is a test example of what the text in the description would look like for the given pokemon. This is a test example of what the text in the description would look like for the given pokemon.", attack: 49, defense: 2, height: 10, weight: 98)
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        // Converte os dados numa string usando a codificação UTF-8.
        let dataAsString = String(data: self, encoding: .utf8)
        
        // Remove "null," , substituindo por uma string vazia.
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        
        // Verifica se a conversão da string modificada para os dados foi bem-sucedida, se não for bem sucedida, retorna nil.
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        
        return data
    }
}
