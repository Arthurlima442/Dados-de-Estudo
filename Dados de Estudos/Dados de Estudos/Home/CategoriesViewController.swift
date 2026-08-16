import UIKit

// MARK: - CategoriesViewController
// Exibe a lista de categorias para estudar

class CategoriesViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .systemBackground
        table.separatorStyle = .singleLine
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        return table
    }()

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura a tela
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Conteúdo de Estudo"

        setupTableView()
        loadData()
    }

    /// Configura a tableview
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }

    /// Carrega as categorias
    private func loadData() {
        viewModel.loadCategories()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {

    /// Retorna quantas categorias tem
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories()
    }

    /// Configura cada célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell

        if let category = viewModel.category(at: indexPath.row) {
            cell.configure(with: category)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {

    /// Navega para category detail quando clica
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let category = viewModel.category(at: indexPath.row) else { return }

        let categoryDetailVM = CategoryDetailViewModel(category: category)
        let categoryDetailVC = CategoryDetailViewController(viewModel: categoryDetailVM)

        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
}
