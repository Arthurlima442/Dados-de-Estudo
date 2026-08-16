import Foundation

class HomeViewModel {

    private let dataService: DataServiceProtocol
    var categories: [Category] = []
    var error: Error?

    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }

    /// Carrega as categorias do JSON via DataService
    func loadCategories() {
        do {
            // Tenta carregar as categorias
            self.categories = try dataService.loadCategories()
        } catch {
            // Se der erro, armazena e limpa as categorias
            self.error = error
            self.categories = []
        }
    }

    /// Retorna quantas categorias foram carregadas
    func numberOfCategories() -> Int {
        return categories.count
    }

    /// Retorna uma categoria específica pelo índice
    func category(at index: Int) -> Category? {
        guard index >= 0 && index < categories.count else { return nil }
        return categories[index]
    }
}
