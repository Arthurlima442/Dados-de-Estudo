//
//  HomeViewController..swift
//  Dados de Estudos
//
//  Created by Arthur Lima on 16/08/26.
//
import UIKit

// MARK: - HomeViewController
// Controla a tela inicial (exibição de categorias)
// Conecta a View, ViewModel e Navigation

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    /// Chamado quando a view é carregada
    override func loadView() {
        view = homeView
    }
    
    /// Chamado após a view ser carregada
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    // MARK: - Setup
    
    /// Configura o delegate e data source da TableView
    private func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.delegate = self
    }
    
    /// Carrega as categorias do ViewModel
    private func loadData() {
        viewModel.loadCategories()
        homeView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    /// Retorna o número de linhas na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories()
    }
    
    /// Configura cada célula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        if let category = viewModel.category(at: indexPath.row) {
            cell.configure(with: category)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    /// Chamado quando o usuário toca em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let category = viewModel.category(at: indexPath.row) else { return }
        
        let categoryDetailVM = CategoryDetailViewModel(category: category)
        let categoryDetailVC = CategoryDetailViewController(viewModel: categoryDetailVM)
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    
    /// Chamado quando a HomeView detecta seleção de categoria
    func homeViewDidSelectCategory(at index: Int) {
        // Pode ser usado para lógica alternativa de navegação
    }
}
