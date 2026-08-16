//
//  DataService.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

// MARK: - DataService Protocol
// ====================================
// Arquivo: DataService.swift
// Localização: Core/Services/
// Responsabilidade: Carregar dados (JSON) e decodificar
//
// Por que uma protocol?
// - Define contrato claro do que a service faz
// - Facilita testes (pode mockar)
// - Desacopla a ViewModel da implementação
//
// A ViewModel nunca acessa DataService direto
// A ViewModel acessa a protocol (abstração)
// Assim podemos trocar a implementação sem quebrar nada
// ====================================

/// Protocol que define como a DataService deve se comportar.
///
/// A ViewModel vai usar essa protocol, não a implementação direta.
/// Assim, podemos trocar a implementação sem mexer na ViewModel.
protocol DataServiceProtocol {
    
    /// Carrega todas as categorias de estudo.
    ///
    /// - Returns: Array de Category (categorias carregadas do JSON)
    /// - Throws: Erro se não conseguir carregar ou decodificar
    func loadCategories() throws -> [Category]
}

// MARK: - DataService Implementation
// ====================================
// Implementação concreta da protocol
// ====================================

/// Implementação de DataServiceProtocol.
///
/// Carrega o arquivo studyData.json do bundle
/// e decodifica em um array de Category.
///
/// Fluxo:
/// 1. Bundle.main.url() -> encontra o arquivo
/// 2. try Data(contentsOf:) -> lê o arquivo
/// 3. JSONDecoder().decode() -> converte em Category
/// 4. Retorna array de Category para a ViewModel
class DataService: DataServiceProtocol {
    
    // MARK: - Properties
    
    /// Nome do arquivo JSON que contém os dados.
    /// Deve estar em Resources/JSON/ no Xcode.
    private let jsonFileName = "studyData"
    
    // MARK: - Methods
    
    /// Carrega todas as categorias do arquivo JSON.
    ///
    /// Passos:
    /// 1. Encontra o arquivo JSON no bundle do app
    /// 2. Lê o conteúdo do arquivo como Data
    /// 3. Decodifica Data em JSON usando JSONDecoder
    /// 4. Mapeia JSON em array de Category
    /// 5. Retorna para quem chamou (geralmente a ViewModel)
    ///
    /// - Returns: Array de Category
    /// - Throws: Erro se arquivo não existir ou JSON for inválido
    func loadCategories() throws -> [Category] {
        
        // MARK: - Step 1: Encontrar o arquivo no bundle
        
        // Bundle.main = seu aplicativo
        // .url(forResource:withExtension:) = busca arquivo
        guard let fileURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
            throw DataServiceError.fileNotFound
        }
        
        // MARK: - Step 2: Ler o conteúdo do arquivo como Data
        
        // Data = informação em formato binário
        // contentsOf: lê o arquivo inteiro
        let fileData = try Data(contentsOf: fileURL)
        
        // MARK: - Step 3: Decodificar JSON em Swift
        
        // JSONDecoder = converte JSON em objetos Swift
        // Precisa saber o tipo (estamos decodificando um dicionário com "categories")
        let decoder = JSONDecoder()
        let jsonObject = try decoder.decode([String: [Category]].self, from: fileData)
        
        // MARK: - Step 4: Extrair o array de categories
        
        // Acessa a chave "categories" do JSON
        // Se não existir, retorna array vazio []
        let categories = jsonObject["categories"] ?? []
        
        // MARK: - Step 5: Retornar para quem chamou
        
        return categories
    }
}

// MARK: - DataServiceError
// ====================================
// Define os possíveis erros da DataService
// Usado para tratamento de erros específico
// ====================================

/// Erros que podem acontecer ao carregar os dados.
enum DataServiceError: LocalizedError {
    
    /// Arquivo JSON não foi encontrado no bundle.
    /// Motivo: arquivo não está adicionado ao Xcode ou nome está errado.
    case fileNotFound
    
    /// Seu erro personalizado com descrição.
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Arquivo studyData.json não foi encontrado no bundle do app."
        }
    }
}
