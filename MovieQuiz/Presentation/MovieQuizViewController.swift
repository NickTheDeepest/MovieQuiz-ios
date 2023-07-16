import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
//    private var questionFactory: QuestionFactoryProtocol?
    private var alertPresenter: AlertPresenter?
    private var presenter: MovieQuizPresenter!
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.contentMode = .scaleToFill
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        imageView.layer.borderWidth = 0
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }

    func show(quiz result: QuizResultsViewModel) {
        let message = presenter.makeResultsMessage()
        
//        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
//            guard let self = self else { return }
//
//            self.presenter.resetQuestionIndex()
//        }
       let alertModel = AlertModel(
            title: result.title,
            message: message,
            buttonText: result.buttonText,
            completion: { [weak self] in
                guard let self = self else { return }
                self.presenter.restartGame()
            },
            id: "GameResults"
        )
        alertPresenter?.show(_ : alertModel)
    }
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        let model = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать еще раз",
            completion: { [weak self] in
                guard let self = self else { return }
                self.presenter.restartGame()
            },
            id: "error"
        )
        alertPresenter?.show(model)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieQuizPresenter(viewController: self)
        imageView.layer.cornerRadius = 20
        alertPresenter = AlertPresenter(viewController: self)
    }
}
