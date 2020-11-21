//
//  ProfilePresenter.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    func loadData()
}
class ProfilePresenter: ProfilePresenterProtocol {
    
    private weak var view: ProfileViewProtocol?
    private let connection: ProfileConnectionProtocol
    
    init(view: ProfileViewProtocol) {
        self.view = view
        connection = ProfileConnection()
        loadData()
    }
    
    func loadData() {
        connection.getProfiles() { [weak self] responde in
            switch responde {
            case .success(let res):
                if let details = res.results?.first {
                    self?.view?.updateView(detail: details)
                } else {
                    self?.view?.showAlert(title: ErrorMessages.title, message: ErrorMessages.internalError)
                }
                
            case .failure(let error):
                self?.view?.showAlert(title: ErrorMessages.title, message: error.localizedDescription)
            }
        }
    }
}
