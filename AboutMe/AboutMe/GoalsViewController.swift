//
//  GoalsViewController.swift
//  AboutMe
//
//  Created by Куаныш Спандияр on 13.02.2025.
//

import Foundation
import UIKit


class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    private let goals: [(title: String, status: Bool)] = [
        ("Graduate from School", true),
        ("Apply to University", true),
        ("Start learning Swift", true),
        ("Build my first app", true),
        ("Get an internship", true),
        ("Graduate from University", false),
        ("Become an iOS Developer at Apple", false),
        ("Marry", false),
        ("Have children", false),
        ("Travel all around the world", false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let goalsText = UILabel()
        goalsText.text = "Goals"
        goalsText.font = UIFont(name: "Rockwell", size: 25)
        goalsText.translatesAutoresizingMaskIntoConstraints = false
        goalsText.numberOfLines = 0
        goalsText.lineBreakMode = .byWordWrapping
        
        view.addSubview(goalsText)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(GoalCell.self, forCellReuseIdentifier: "GoalCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            goalsText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            goalsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: goalsText.bottomAnchor, constant: 10), // Adjusted this too
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as! GoalCell
        let goal = goals[indexPath.row]
        cell.configure(goal: goal.title, isCompleted: goal.status, isLast: indexPath.row == goals.count - 1)
        return cell
    }
}

// MARK: - Custom Goal Cell
class GoalCell: UITableViewCell {
    
    private let goalLabel = UILabel()
    private let statusCircle = UIView()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        statusCircle.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        contentView.addSubview(statusCircle)
        contentView.addSubview(goalLabel)
        

        
        NSLayoutConstraint.activate([
            
            
            
            
            statusCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            statusCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statusCircle.widthAnchor.constraint(equalToConstant: 20),
            statusCircle.heightAnchor.constraint(equalToConstant: 20),
            statusCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            goalLabel.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 20),
            goalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            goalLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            goalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        statusCircle.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(goal: String, isCompleted: Bool, isLast: Bool) {
        goalLabel.text = goal
        goalLabel.font = UIFont(name: "Rockwell", size: 17)
        goalLabel.textColor = isCompleted ? .systemGreen : .label
        statusCircle.backgroundColor = isCompleted ? .systemGreen : .systemGray
    }
}
