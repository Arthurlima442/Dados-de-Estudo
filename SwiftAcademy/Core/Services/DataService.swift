import Foundation

protocol DataServiceProtocol {
    func loadCategories() throws -> [Category]
}

class DataService: DataServiceProtocol {

    private let jsonFileName = "studyData"

    /// Carrega as categorias do arquivo JSON via DataService
    func loadCategories() throws -> [Category] {
        guard let fileURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
            throw DataServiceError.fileNotFound
        }

        let fileData = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let jsonObject = try decoder.decode([String: [Category]].self, from: fileData)

        let categories = jsonObject["categories"] ?? []
        return categories
    }
}

enum DataServiceError: LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Arquivo studyData.json não foi encontrado no bundle do app."
        }
    }
}
