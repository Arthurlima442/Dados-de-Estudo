import UIKit

class CategoryDetailViewController: UIViewController {

    private let categoryDetailView = CategoryDetailView()
    private let viewModel: CategoryDetailViewModel

    init(viewModel: CategoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Carrega a view customizada
    override func loadView() {
        view = categoryDetailView
    }

    /// Configura a tela e carrega os dados
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }

    /// Define o título da controller e aparência
    private func setupUI() {
        title = viewModel.categoryTitle()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    /// Configura o delegate e data source da TableView
    private func setupTableView() {
        categoryDetailView.tableView.delegate = self
        categoryDetailView.tableView.dataSource = self
    }

    /// Preenche a view com dados do ViewModel
    private func loadData() {
        categoryDetailView.setDescription(viewModel.categoryDescription())
        categoryDetailView.tableView.reloadData()
    }
}

extension CategoryDetailViewController: UITableViewDataSource {

    /// Retorna quantos tópicos tem nesta categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTopics()
    }

    /// Cria e configura cada célula com dados de um tópico
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.identifier, for: indexPath) as! TopicCell

        if let topic = viewModel.topic(at: indexPath.row) {
            cell.configure(with: topic)
        }

        return cell
    }
}

extension CategoryDetailViewController: UITableViewDelegate {

    /// Navega para a tela de estudo quando o usuário toca em um tópico
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let topic = viewModel.topic(at: indexPath.row) else { return }

        // Cria ViewModel e Controller da tela de estudo
        let studyVM = StudyViewModel(topic: topic)
        let studyVC = StudyViewController(viewModel: studyVM)

        // Navega para a tela
        navigationController?.pushViewController(studyVC, animated: true)
    }
}
