import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Carrega a view customizada
    override func loadView() {
        view = homeView
    }

    /// Configura a tela e carrega os dados
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBotaoQuiz()
        loadData()
    }

    /// Configura o delegate e data source da TableView
    private func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }

    /// Configura os botões
    private func setupBotaoQuiz() {
        homeView.botaoQuiz.addTarget(self, action: #selector(abrirQuiz), for: .touchUpInside)
        homeView.botaoConteudo.addTarget(self, action: #selector(scrollParaConteudo), for: .touchUpInside)
    }

    /// Abre a tela de quiz
    @objc private func abrirQuiz() {
        let quizVM = QuizViewModel()
        let quizVC = QuizViewController(viewModel: quizVM)
        navigationController?.pushViewController(quizVC, animated: true)
    }

    /// Faz scroll para a tabela de conteúdo
    @objc private func scrollParaConteudo() {
        homeView.tableView.setContentOffset(.zero, animated: true)
    }

    /// Carrega as categorias do ViewModel
    private func loadData() {
        viewModel.loadCategories()
        homeView.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {

    /// Retorna quantas categorias foram carregadas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories()
    }

    /// Cria e configura cada célula com dados de uma categoria
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell

        if let category = viewModel.category(at: indexPath.row) {
            cell.configure(with: category)
        }

        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

    /// Navega para a tela de categoria quando o usuário toca em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let category = viewModel.category(at: indexPath.row) else { return }

        // Cria ViewModel e Controller da tela de categoria
        let categoryDetailVM = CategoryDetailViewModel(category: category)
        let categoryDetailVC = CategoryDetailViewController(viewModel: categoryDetailVM)

        // Navega para a tela
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
}
