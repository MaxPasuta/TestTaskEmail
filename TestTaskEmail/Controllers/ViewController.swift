//
//  ViewController.swift
//  TestTaskEmail
//
//  Created by Максим Пасюта on 21.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let statusLabel = StatusLabel()
    private let mailTextField = MailTextField()
    private let verificationButton = VerificationButton()
    private let colletcionView = MailCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    private lazy var stackView = UIStackView(arrangedSubviews: [mailTextField,
                                                               verificationButton,
                                                               colletcionView],
                                             axis: .vertical,
                                             spacing: 20)
    
    private let verificationModel = VerificationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        verificationButton.addTarget(self, action: #selector(verificationButtonTapped), for: .touchUpInside)
      
        
    }
    private func setDelegates(){
        colletcionView.dataSource = self
        colletcionView.selectMailDelegate = self
        mailTextField.textFieldDelegate = self
    }
    @objc private func verificationButtonTapped(){
        guard let mail = mailTextField.text else { return }
        
        NetworkDataFetch.shader.fetchmail(verifiableMail: mail) { result, error in
            if error == nil {
                guard let result = result else { return }
                
                if result.success{
                    guard let didYouMeanError = result.did_you_mean else {
                        Alerts.showResultAlert(vc: self,
                                               message: "Mail status \(result.result) \n \(result.reasonDescription)")
                        return
                    }
                    Alerts.showErrorAlert(vc: self, message: "Did you mean \(didYouMeanError)") { [weak self] in
                        guard let self = self else { return }
                        self.mailTextField.text = didYouMeanError
                    }
                    
                }
            }
            else {
                guard let errorDescription = error?.localizedDescription else { return }
                Alerts.showResultAlert(vc: self, message: errorDescription)
            }
        }
    }
    
}

//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filteredMailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idMailCell.rawValue, for: indexPath) as? MailCollectionViewCell
                
        else {
            return UICollectionViewCell()
            
        }
        
        let mailLabelText = verificationModel.filteredMailArray[indexPath.row]
        cell.cellConfigure(mailLabelText: mailLabelText)
        return cell
    }
}


//MARK: - SelectProposedMailProtocol

extension ViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = mailTextField.text else {return}
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filteredMailArray[indexPath.row]
        let mailFullName = verificationModel.nameMail + domainMail
        mailTextField.text = mailFullName
        statusLabel.isValid = mailFullName.isValid()
        verificationButton.isValid = mailFullName.isValid()
        verificationModel.filteredMailArray = []
        colletcionView.reloadData()
    }
}

//MARK: - ActionsMailTextFieldprotocol

extension ViewController: ActionsMailTextFieldprotocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFilteredMail(text: text)
        colletcionView.reloadData()
    }
    
    func cleanOutTextField() {
        statusLabel.setDefaultSetting()
        verificationButton.setDefaultSetting()
        verificationModel.filteredMailArray = []
        colletcionView.reloadData()
    }
    
    
}

//MARK: - SetConstraints

extension ViewController {
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    
    }
}

