import UIKit

class CategoryDetailViewController: UIViewController {

    private let categoryDetailView = CategoryDetailView()
    private let viewModel: CategoryDetailViewModel

    // MARK: - Init

    init(viewModel: CategoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    /// Carrega a view customizada
    override func loadView() {
        view = categoryDetailView
    }

    /// Configura a controller após a view carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }

    // MARK: - Setup

    /// Configura o título e aparência da controller
    private func setupUI() {
        title = viewModel.categoryTitle()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    /// Configura delegate e data source da TableView
    private func setupTableView() {
        categoryDetailView.tableView.delegate = self
        categoryDetailView.tableView.dataSource = self
    }

    /// Carrega e exibe os dados do ViewModel
    private func loadData() {
        categoryDetailView.setDescription(viewModel.categoryDescription())
        categoryDetailView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CategoryDetailViewController: UITableViewDataSource {

    /// Retorna o número de tópicos na categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTopics()
    }

    /// Configura cada célula com dados de um tópico
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.identifier, for: indexPath) as! TopicCell

        if let topic = viewModel.topic(at: indexPath.row) {
            cell.configure(with: topic)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryDetailViewController: UITableViewDelegate {

    /// Chamado quando o usuário seleciona um tópico
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let topic = viewModel.topic(at: indexPath.row) else { return }

        let studyVM = StudyViewModel(topic: topic)
        let studyVC = StudyViewController(viewModel: studyVM)
        navigationController?.pushViewController(studyVC, animated: true)
    }
}
