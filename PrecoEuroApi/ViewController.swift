//
//  ViewController.swift
//  PrecoEuroApi
//
//  Created by Luan.Lima on 19/04/22.
//
import TransitionButton
import UIKit

class ViewController: UIViewController {
    
    // MARK: Dependencie
    
    private let service = Service()
    
    //MARK: UIView
    
    private lazy var button: TransitionButton = {
        let button = TransitionButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.setTitle("Consultar", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapView), for: .touchUpInside)
        button.spinnerColor = .white
        
        return button
    }()
    
    
    private lazy var imagem: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "euro")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var productValue: UILabel = {
        let label = UILabel()
        label.text = "R$ 0.00"
        label.font = label.font.withSize(50)
        label.textAlignment = .center
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imagem, productValue, button])
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEuroValue()
    }
    
    //MARK:  Private Functions
    
    @objc func didTapView() {
        updateEuroValue()
    }
    
    func alertaAction() {
        let alert = UIAlertController(title: "Erro ao consultar", message: "Tente novamente mais tarde.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateEuroValue() {
        button.startAnimation()
        service.euroValue { (preco, erro) -> (Void) in
            self.button.stopAnimation(animationStyle: .normal, revertAfterDelay: 1)
            if erro != nil {
                self.alertaAction()
                return
            }
            self.productValue.text = preco
        }
    }
}

//MARK: - ViewCode

extension ViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagem.heightAnchor.constraint(equalToConstant: 200),
            imagem.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
}
