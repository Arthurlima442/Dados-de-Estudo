import Foundation

protocol DataServiceProtocol {
    func loadCategories() throws -> [Category]
}

class DataService: DataServiceProtocol {

    private let jsonFileName = "studyData"

    /// Carrega o arquivo JSON e decodifica em array de Category
    func loadCategories() throws -> [Category] {
        // Encontra o arquivo JSON no bundle do app
        guard let fileURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
            throw DataServiceError.fileNotFound
        }

        // Lê o conteúdo do arquivo como Data (bytes)
        let fileData = try Data(contentsOf: fileURL)

        // Decodifica JSON em Dictionary com "categories"
        let decoder = JSONDecoder()
        let jsonObject = try decoder.decode([String: [Category]].self, from: fileData)

        // Extrai o array de categorias (retorna vazio se não existir)
        let categories = jsonObject["categories"] ?? []

        return categories
    }
}

enum DataServiceError: LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        return "Arquivo studyData.json não foi encontrado no bundle."
    }
}
