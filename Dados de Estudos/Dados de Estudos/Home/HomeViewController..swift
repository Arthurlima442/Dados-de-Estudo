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

    /// Configura a tela
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBotoes()
    }

    /// Configura os botões
    private func setupBotoes() {
        homeView.botaoQuiz.addTarget(self, action: #selector(abrirQuiz), for: .touchUpInside)
        homeView.botaoConteudo.addTarget(self, action: #selector(abrirConteudo), for: .touchUpInside)
    }

    /// Abre a tela de quiz
    @objc private func abrirQuiz() {
        let quizVM = QuizViewModel()
        let quizVC = QuizViewController(viewModel: quizVM)
        navigationController?.pushViewController(quizVC, animated: true)
    }

    /// Abre a tela de conteúdo
    @objc private func abrirConteudo() {
        let categoriesVC = CategoriesViewController(viewModel: viewModel)
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
}
