//
//  SessionCell.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import UIKit
import SnapKit

class SessionCell: UITableViewCell {
    
    var session: SessionExercisesResponse? {
        didSet{
            sessionName.text = "Name: \(session?.name ?? String())"
            sessionPracticedAtBpm.text = "practicedAtBpm: \(session?.practicedAtBpm ?? Int())"
        }
    }
    
    private let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let sessionName : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let sessionDatePracticed : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let sessionPracticedAtBpm : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func formatDate(str: String) -> String {
        let pre = str.prefix(10)
        return String(pre)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        mainView.addSubview(sessionName)
        mainView.addSubview(sessionDatePracticed)
        mainView.addSubview(sessionPracticedAtBpm)
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            
        }
        
        sessionName.snp.makeConstraints { (make) in
            make.top.equalTo(mainView).offset(5)
            make.left.equalTo(mainView).offset(10)
            make.right.equalTo(mainView).offset(-10)
        }
        
        sessionDatePracticed.snp.makeConstraints { (make) in
            make.top.equalTo(sessionName.snp.bottom).offset(5)
            make.left.equalTo(mainView).offset(10)
            make.right.equalTo(mainView).offset(-10)
        }
        
        sessionPracticedAtBpm.snp.makeConstraints { (make) in
            make.top.equalTo(sessionDatePracticed.snp.bottom).offset(5)
            make.left.equalTo(mainView).offset(10)
            make.right.equalTo(mainView).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
