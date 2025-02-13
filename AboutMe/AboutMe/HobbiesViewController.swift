//
//  HobbiesViewController.swift
//  AboutMe
//
//  Created by Куаныш Спандияр on 13.02.2025.
//

import Foundation
import UIKit


class HobbiesViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "football") // Set a default image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent overlay
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()

    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "Football"
        label.textColor = .white
        label.font = UIFont(name: "Rockwell", size: 45)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let hobbyDescription: UILabel = {
        let label = UILabel()
        label.text = "From weekend to weekend, we gather with my friends to play football. It is one of my favorite hobbies."
        label.font = UIFont(name: "Rockwell", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let buttonTitles = ["⚽ Football", "✈️ Traveling", "🌃Exploring"]
    let buttonImages = ["football", "mountain1", "city"]
    let buttonTexts = ["Football", "Mountains", "City Sights"]
    
    let buttonTextDesc = ["From weekend to weekend, we gather with my friends to play football. It is one of my favorite hobbies.",
                          
        "I really like traveling to precious places of our counrty's nature. It gives me energy when I'm exhausted.",
                          
        "When I am in my hometown, I always seek for adventure, I like to explore new places and discover hidden gems of my city."]
    
    var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        //title = "Hobbies"
        
        let listHobbies = UILabel()
        listHobbies.text = "List of Hobbies"
        listHobbies.font = UIFont(name: "Rockwell", size: 25)
        listHobbies.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listHobbies)
        
        let hobbiesText = UILabel()
        hobbiesText.text = "When I have free time, I usually like to play football with my mates. Also, I really like traveling to precious places of our counrty's nature."
        hobbiesText.font = UIFont(name: "Rockwell", size: 25)
        hobbiesText.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            listHobbies.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listHobbies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ])
        

        
        view.addSubview(imageView)
        
        
        imageView.addSubview(overlayView)
        overlayView.addSubview(hobbyLabel)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            overlayView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            
            hobbyLabel.topAnchor.constraint(equalTo:
                overlayView.topAnchor, constant: 30),
            hobbyLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
        ])
        
        
        // Image Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: listHobbies.bottomAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.1)
        ])
        
        
        view.addSubview(hobbyDescription)
        
        NSLayoutConstraint.activate([
            
            hobbyDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            hobbyDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hobbyDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: hobbyDescription.bottomAnchor, constant: 30),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(lessThanOrEqualToConstant: 60)
        ])

        
        // Creating buttons
        for (index, title) in buttonTitles.enumerated() {
            let button = createButton(title: title, tag: index)
            buttonStack.addArrangedSubview(button)
        }
        
        
        
    }
    

    
    func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rockwell", size: 16)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Reset previous button
        selectedButton?.isSelected = false
        selectedButton?.backgroundColor = UIColor.systemGray5
        
        // Highlight new button
        sender.isSelected = true
        sender.backgroundColor = UIColor.systemBlue
        selectedButton = sender
        
        // Change image based on button tag
        imageView.image = UIImage(named: buttonImages[sender.tag])
        hobbyLabel.text = buttonTexts[sender.tag]
        hobbyDescription.text =  buttonTextDesc[sender.tag]
    
        
        // Animate the image change
        UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
