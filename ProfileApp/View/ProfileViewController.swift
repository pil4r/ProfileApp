//
//  ProfileView.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func updateView(detail: ResultDetail)
    func showAlert(title: String, message: String)
}

final class ProfileViewController: UIViewController {
    //MARK: cons
    private let minHeight: CGFloat = 250
    private let maxHeight: CGFloat = 500
    
    //MARK: vars
    private var presenter: ProfilePresenterProtocol?
    private var refreshControl = UIRefreshControl()

    //MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var dateRegisteredLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var celularLabel: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint! //500 - 210
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var postalCodeLabel: UILabel!
    private var once = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if once {
            headerView.AddBottomCurve(curve: 1)
            once = false
        }
        
    }
    
    
    private func initView() {
        presenter = ProfilePresenter(view: self)
    }
    
    private func setupView() {
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        self.refreshControl.tintColor = UIColor.lightGray
        self.refreshControl.attributedTitle = NSAttributedString(string: "Update")
        self.refreshControl.addTarget(self, action: #selector(refreshView), for: UIControl.Event.valueChanged)
        scrollView.addSubview(refreshControl)
        
        detailsView.layer.cornerRadius = 20.0
        detailsView.layer.shadowColor = UIColor.gray.cgColor
        detailsView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        detailsView.layer.shadowRadius = 12.0
        detailsView.layer.shadowOpacity = 0.7
    }
    
    @IBAction func showDetailsAction(_ sender: UIButton) {
        var heightValue: CGFloat = maxHeight
        if sender.tag > 1 {
            heightValue = minHeight
            detailsButton.tag = 0
            detailsButton.setTitle(ButtonsTitle.showInfo, for: .normal)
        } else {
            detailsButton.tag = 2
            detailsButton.setTitle(ButtonsTitle.hideInfo, for: .normal)
        }
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.bottomViewHeight.constant = heightValue
            self.detailsView.isHidden = sender.tag < 2
        })
    }
    
    @objc private func refreshView() {
        presenter?.loadData()
        refreshControl.endRefreshing()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func showAlert(title: String, message: String) {
        presentAlertView(title: title, message: message)
    }
    
    func updateView(detail: ResultDetail) {
        profileImageView.getImage(url: detail.picture?.medium)
        nameLabel.text = String(format: "%@ %@ %@", detail.name?.title ?? "", detail.name?.first ?? "", detail.name?.last ?? "")
        usernameLabel.text = detail.login?.username
        emailLabel.text = detail.email ?? "-"
        phoneLabel.text = detail.phone ?? "-"
        celularLabel.text = detail.cell ?? "-"
        dateRegisteredLabel.text?.formatDate(text: detail.registered?.date ?? "-")
        addressLabel.text = String(format: "%d %@", detail.location?.street?.number ?? 0, detail.location?.street?.name ?? "")
        cityLabel.text = detail.location?.city ?? ""
        stateLabel.text = detail.location?.state ?? ""
        countryLabel.text = detail.location?.country ?? ""
        guard let postalCode = detail.location?.postcode else {
            return
        }
        postalCodeLabel.text = String(format: "%d", postalCode)
    }
}
