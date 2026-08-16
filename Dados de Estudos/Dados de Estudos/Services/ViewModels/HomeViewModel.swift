//
//  HomeViewModel.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

// MARK: - HomeViewModel
// ====================================
// Arquivo: HomeViewModel.swift
// Localização: Core/ViewModels/
// Responsabilidade: Gerenciar dados da tela inicial
//
// O que faz:
// 1. Carrega as categorias do Service
// 2. Formata os dados para exibir
// 3. Fornece dados prontos para a HomeViewController
//
// POR QUE EXISTE?
// A ViewController não deve chamar Service diretamente
// A ViewController chama HomeViewModel
// HomeViewModel chama Service e prepara os dados
// Assim a lógica fica organizada e testável
//
// RESPONSABILIDADES:
// ✅ Carregar dados do Service
// ✅ Processar/transformar dados
// ✅ Fornecer dados para ViewController
// ❌ NÃO cria Views
// ❌ NÃO sabe sobre UIKit
// ====================================

/// ViewModel da tela inicial (HomeViewController).
///
/// Gerencia o carregamento e exibição das categorias.
/// É responsável por fazer a ponte entre o Service e a ViewController.
///
/// Fluxo:
/// 1. HomeViewController inicializa HomeViewModel
/// 2. HomeViewController chama loadCategories()
/// 3. HomeViewModel chama dataService.loadCategories()
/// 4. Service retorna array de Category
/// 5. HomeViewModel armazena em self.categories
/// 6. HomeViewController lê self.categories e exibe na tela
class HomeViewModel {
    
    // MARK: - Properties
    
    /// Service responsável por carregar os dados.
    /// Usamos a protocol (abstração) não a implementação.
    /// Assim podemos trocar a implementação sem quebrar o ViewModel.
    private let dataService: DataServiceProtocol
    
    /// Array de categorias carregadas do JSON.
    /// Inicializado vazio, depois populado por loadCategories().
    /// A ViewController lê esse array para exibir na tela.
    var categories: [Category] = []
    
    /// Armazena erros que acontecem durante o carregamento.
    /// Se loadCategories() falhar, o erro fica aqui.
    /// A ViewController pode verificar esse erro e exibir mensagem.
    var error: Error?
    
    /// Indica se os dados estão sendo carregados.
    /// Útil para exibir loading na tela enquanto aguarda.
    var isLoading: Bool = false
    
    // MARK: - Init
    
    /// Inicializa o ViewModel com um Service.
    ///
    /// - Parameter dataService: O serviço responsável por carregar dados.
    ///                         Pode ser a implementação real ou um mock para testes.
    ///
    /// Por que passar o Service no init?
    /// - Injeção de dependência (Dependency Injection)
    /// - Facilita testes (pode passar um mock)
    /// - Deixa o código desacoplado
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
    
    // MARK: - Methods
    
    /// Carrega as categorias do Service.
    ///
    /// Este é o método principal chamado pela ViewController.
    /// Executa os passos:
    /// 1. Define isLoading = true (começa a carregar)
    /// 2. Chama dataService.loadCategories()
    /// 3. Se sucesso: armazena em self.categories
    /// 4. Se erro: armazena em self.error
    /// 5. Define isLoading = false (terminou de carregar)
    ///
    /// A ViewController chama este método e depois lê self.categories.
    func loadCategories() {
        // Indica que está carregando.
        isLoading = true
        
        // Limpa erro anterior (se houver).
        error = nil
        
        do {
            // Chama o Service para carregar categorias.
            // Service já faz todo o trabalho de:
            // - Encontrar arquivo
            // - Ler arquivo
            // - Decodificar JSON
            // - Retornar array de Category
            self.categories = try dataService.loadCategories()
        } catch {
            // Se algo der errado, armazena o erro.
            self.error = error
            self.categories = [] // Limpa categorias (se houver).
        }
        
        // Terminou de carregar.
        isLoading = false
    }
    
    /// Retorna a quantidade de categorias.
    ///
    /// Método auxiliar usado pela ViewController
    /// para saber quantas linhas exibir na table view.
    ///
    /// - Returns: Número de categorias carregadas.
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    /// Retorna uma categoria específica pelo índice.
    ///
    /// Método auxiliar usado pela ViewController
    /// para obter os dados de uma célula específica.
    ///
    /// - Parameter index: Índice da categoria (0, 1, 2, etc).
    /// - Returns: A categoria no índice especificado.
    func category(at index: Int) -> Category? {
        guard index >= 0 && index < categories.count else {
            return nil
        }
        return categories[index]
    }
}
