import UIKit

class StudyViewController: UIViewController {

    private let studyView = StudyView()
    private let viewModel: StudyViewModel

    // MARK: - Init

    init(viewModel: StudyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    /// Carrega a view customizada (StudyView)
    override func loadView() {
        view = studyView
    }

    /// Configura a controller e carrega os dados após a view ser carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    // MARK: - Setup

    /// Define o título da controller com o nome do tópico
    private func setupUI() {
        title = viewModel.topicTitle()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    /// Busca o conteúdo do ViewModel e exibe na view
    private func loadData() {
        let content = viewModel.content()
        studyView.configure(with: content)
    }
}
