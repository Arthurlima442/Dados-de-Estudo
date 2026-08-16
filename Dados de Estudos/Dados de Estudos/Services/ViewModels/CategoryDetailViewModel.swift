//
//  CategoryDetailViewModel.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

// MARK: - CategoryDetailViewModel
// ====================================
// Arquivo: CategoryDetailViewModel.swift
// Localização: Core/ViewModels/
// Responsabilidade: Gerenciar dados de uma categoria específica
//
// O que faz:
// 1. Recebe a categoria selecionada da HomeViewController
// 2. Armazena a categoria
// 3. Fornece os tópicos da categoria para exibir
//
// POR QUE EXISTE?
// Cada tela tem seu próprio ViewModel
// HomeViewController tem HomeViewModel
// CategoryDetailViewController tem CategoryDetailViewModel
// Assim cada ViewController gerencia seus dados separadamente
//
// NOTA: Este ViewModel NÃO chama Service
// Ele recebe a categoria já carregada pela HomeViewController
// Então apenas formata e fornece os dados
// ====================================

/// ViewModel da tela de categoria (CategoryDetailViewController).
///
/// Gerencia os dados de uma categoria específica.
/// Fornece os tópicos dentro daquela categoria.
///
/// Fluxo:
/// 1. HomeViewController seleciona uma categoria
/// 2. HomeViewController inicializa CategoryDetailViewController
/// 3. HomeViewController passa a categoria para CategoryDetailViewModel
/// 4. CategoryDetailViewController chama os métodos do ViewModel
/// 5. ViewModel retorna os tópicos daquela categoria
class CategoryDetailViewModel {
    
    // MARK: - Properties
    
    /// A categoria que está sendo exibida.
    /// É recebida no init (vem da HomeViewController).
    /// Contém todos os tópicos dessa categoria.
    private let category: Category
    
    // MARK: - Init
    
    /// Inicializa o ViewModel com uma categoria.
    ///
    /// - Parameter category: A categoria selecionada na tela anterior.
    ///
    /// Diferente do HomeViewModel, este recebe a categoria no init.
    /// Não precisa carregar do Service porque já foi carregado antes.
    init(category: Category) {
        self.category = category
    }
    
    // MARK: - Methods
    
    /// Retorna o título da categoria.
    ///
    /// - Returns: Nome da categoria para exibir no título da tela.
    func categoryTitle() -> String {
        return category.title
    }
    
    /// Retorna a descrição da categoria.
    ///
    /// - Returns: Descrição breve da categoria.
    func categoryDescription() -> String {
        return category.description
    }
    
    /// Retorna a quantidade de tópicos da categoria.
    ///
    /// Método auxiliar usado pela ViewController
    /// para saber quantas linhas exibir na table view.
    ///
    /// - Returns: Número de tópicos nesta categoria.
    func numberOfTopics() -> Int {
        return category.topics.count
    }
    
    /// Retorna um tópico específico pelo índice.
    ///
    /// Método auxiliar usado pela ViewController
    /// para obter os dados de uma célula específica.
    ///
    /// - Parameter index: Índice do tópico (0, 1, 2, etc).
    /// - Returns: O tópico no índice especificado.
    func topic(at index: Int) -> Topic? {
        guard index >= 0 && index < category.topics.count else {
            return nil
        }
        return category.topics[index]
    }
    
    /// Retorna todos os tópicos da categoria.
    ///
    /// - Returns: Array de Topic (tópicos da categoria).
    func allTopics() -> [Topic] {
        return category.topics
    }
}
