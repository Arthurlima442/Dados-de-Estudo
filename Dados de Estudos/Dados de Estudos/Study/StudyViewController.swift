import UIKit

class StudyViewController: UIViewController {

    private let studyView = StudyView()
    private let viewModel: StudyViewModel

    init(viewModel: StudyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Carrega a view customizada
    override func loadView() {
        view = studyView
    }

    /// Configura a tela e carrega os dados
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    /// Define o título da controller
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
