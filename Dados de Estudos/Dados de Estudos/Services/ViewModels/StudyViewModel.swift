//
//  StudyViewModel.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

// MARK: - StudyViewModel
// ====================================
// Arquivo: StudyViewModel.swift
// Localização: Core/ViewModels/
// Responsabilidade: Gerenciar dados de um tópico de estudo
//
// O que faz:
// 1. Recebe o tópico selecionado
// 2. Formata o conteúdo para exibir
// 3. Fornece explanation, example, keyPoints prontos
//
// POR QUE EXISTE?
// Assim como cada tela tem seu ViewModel
// StudyViewController tem StudyViewModel
// Ele recebe o tópico já carregado
// Então apenas formata e fornece os dados
//
// RESPONSABILIDADES:
// ✅ Formatar conteúdo para exibir
// ✅ Fornecer explanation, example, keyPoints
// ✅ Gerenciar informações do tópico atual
// ❌ NÃO chama Service
// ❌ NÃO carrega dados
// ====================================

/// ViewModel da tela de estudo (StudyViewController).
///
/// Gerencia os dados de um tópico de estudo específico.
/// Fornece a explicação, exemplo e pontos-chave.
///
/// Fluxo:
/// 1. CategoryDetailViewController seleciona um tópico
/// 2. CategoryDetailViewController inicializa StudyViewController
/// 3. CategoryDetailViewController passa o tópico para StudyViewModel
/// 4. StudyViewController chama os métodos do ViewModel
/// 5. ViewModel retorna os dados formatados
class StudyViewModel {
    
    // MARK: - Properties
    
    /// O tópico que está sendo estudado.
    /// É recebido no init (vem da CategoryDetailViewController).
    /// Contém a explicação, exemplo e pontos-chave.
    private let topic: Topic
    
    // MARK: - Init
    
    /// Inicializa o ViewModel com um tópico.
    ///
    /// - Parameter topic: O tópico selecionado na tela anterior.
    init(topic: Topic) {
        self.topic = topic
    }
    
    // MARK: - Methods
    
    /// Retorna o título do tópico.
    ///
    /// - Returns: Nome do tópico para exibir como título.
    func topicTitle() -> String {
        return topic.title
    }
    
    /// Retorna a explicação do tópico.
    ///
    /// - Returns: Texto com a explicação detalhada do conceito.
    func explanation() -> String {
        return topic.content.explanation
    }
    
    /// Retorna o exemplo de código do tópico.
    ///
    /// - Returns: Código de exemplo para o conceito.
    func example() -> String {
        return topic.content.example
    }
    
    /// Retorna os pontos-chave do tópico.
    ///
    /// - Returns: Array de strings com os pontos importantes.
    func keyPoints() -> [String] {
        return topic.content.keyPoints
    }
    
    /// Retorna todos os dados do tópico formatados.
    ///
    /// Método auxiliar que retorna um objeto com todos os dados.
    /// Útil se preferir passar um objeto ao invés de chamar vários métodos.
    ///
    /// - Returns: O conteúdo completo do tópico.
    func content() -> StudyContent {
        return topic.content
    }
}
