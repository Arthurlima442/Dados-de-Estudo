//
//  CategoryDetailViewModel.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

class CategoryDetailViewModel {
    
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    /// Retorna o título da categoria
    func categoryTitle() -> String {
        return category.title
    }
    
    /// Retorna a descrição da categoria
    func categoryDescription() -> String {
        return category.description
    }
    
    /// Retorna a quantidade de tópicos na categoria
    func numberOfTopics() -> Int {
        return category.topics.count
    }
    
    /// Retorna um tópico específico pelo índice
    func topic(at index: Int) -> Topic? {
        guard index >= 0 && index < category.topics.count else { return nil }
        return category.topics[index]
    }
}
