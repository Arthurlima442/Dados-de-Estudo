import Foundation

protocol DataServiceProtocol {
    func loadCategories() throws -> [Category]
    func loadQuizzes() throws -> [Quiz]
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

        // Cria um struct temporário para decodificar
        struct JSONData: Codable {
            let categories: [Category]
        }

        // Decodifica JSON
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(JSONData.self, from: fileData)

        return jsonData.categories
    }

    /// Carrega os quizzes do arquivo JSON (dados mockados, não usa JSON)
    func loadQuizzes() throws -> [Quiz] {
        // Retorna array vazio (quizzes são mockados no ViewModel)
        return []
    }
}

enum DataServiceError: LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        return "Arquivo studyData.json não foi encontrado no bundle."
    }
}
