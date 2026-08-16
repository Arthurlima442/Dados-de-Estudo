//
//  HomeViewModel.swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import Foundation

class HomeViewModel {
    
    private let dataService: DataServiceProtocol
    var categories: [Category] = []
    var error: Error?
    var isLoading: Bool = false
    
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
    
    /// Carrega as categorias do arquivo JSON via DataService
    func loadCategories() {
        isLoading = true
        error = nil
        
        do {
            self.categories = try dataService.loadCategories()
        } catch {
            self.error = error
            self.categories = []
        }
        
        isLoading = false
    }
    
    /// Retorna a quantidade de categorias carregadas
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    /// Retorna uma categoria específica pelo índice
    func category(at index: Int) -> Category? {
        guard index >= 0 && index < categories.count else { return nil }
        return categories[index]
    }
}

