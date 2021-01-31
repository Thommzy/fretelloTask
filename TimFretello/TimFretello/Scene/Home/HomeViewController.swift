//
//  HomeViewController.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import UIKit

protocol GetDataDisplayLogic {
    func displayDataAlert(alert: [SessionsResponse])
    func displayErrorAlert(alert: String)
}

class HomeViewController: UIViewController, GetDataDisplayLogic, UITableViewDelegate, UITableViewDataSource {
    
    var interactor : GetDataBusinessLogic?
    var sessionTableView  = UITableView()
    
    var highestLabel = UILabel()
    
    let cellId = FreTello.cellId
    var session : [SessionsResponse] = []
    
    func displayDataAlert(alert: [SessionsResponse]) {
        session += alert
        let array = session.map{$0.exercises.map{$0?.practicedAtBpm ?? Int()}}
        print(array)
        let maximum = getMax(array)
        print(maximum)
        highestLabel.text = "   Maximum Practice Performance: \(maximum)%"
        sessionTableView.reloadData()
    }
    
//    func getAverage(arr: [Int]) -> Double {
//        let total = arr.reduce(0, +)
//        let count = arr.count
//        let average = Double(total)/Double(count)
//        return average
//    }
//
//    func getHighest(arr: [Int]) -> Int {
//        let highest = arr.max()
//        return highest ?? Int()
//    }
//
//    func getPercentagePerAverage(highest: Int, average: Double) -> Int {
//        let percent = highest * 100
//        let final = Double(percent) / average
//        let convertFinalToInt = Int(final)
//        return convertFinalToInt
//    }
    
    func displayErrorAlert(alert: String) {
        print("<<Error>>",alert)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        interactor?.getData()
        
        setupHighestLabel()
        setupSessionTableView()
        
        sessionTableView.reloadData()
        setupNavigationLogo()
        sessionTableView.delegate = self
        sessionTableView.dataSource = self
        
    }
    
    func setupHighestLabel() {
        view.addSubview(highestLabel)
        highestLabel.textColor = .white
        highestLabel.backgroundColor = .black
        highestLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.height.equalTo(50)
        }
    }
    
    func setupSessionTableView() {
        view.addSubview(sessionTableView)
        sessionTableView.snp.makeConstraints { (make) in
            make.top.equalTo(highestLabel.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            //make.edges.equalTo(view)
        }
        sessionTableView.register(SessionCell.self, forCellReuseIdentifier: cellId)
    }
    
  
    
    func setupNavigationLogo() {
        
        let logo = UIImage(named: FreTello.logo)
        let imageView = UIImageView(image:logo)
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        self.navigationItem.titleView = imageView
        
    }
    
    
    func setup() {
        let presenter = GetDataPresenter()
        presenter.view = self
        let networkClient = FreTelloApiClient()
        let worker = GetDataWorker()
        worker.networkClient = networkClient
        let interactor = GetDataInteractor()
        interactor.worker = worker
        interactor.presenter = presenter
        self.interactor = interactor
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session[section].exercises.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return session.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let sectionHeader = UIView()
        
        sectionHeader.backgroundColor = .black
        
        let nameLabel = UILabel()
        nameLabel.text = (session[section].name)?.uppercased()
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.frame = CGRect(x: 15, y: -7 , width: self.view.frame.width, height: 50)
        sectionHeader.addSubview(nameLabel)
        
        let dateLabel = UILabel()
        dateLabel.text = String((session[section].practicedOnDate)?.prefix(10) ?? "")
        dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        dateLabel.frame = CGRect(x: 15, y: 7 , width: self.view.frame.width, height: 50)
        sectionHeader.addSubview(dateLabel)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SessionCell
        let current = session[indexPath.section].exercises[indexPath.row]
        cell.session = current
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
