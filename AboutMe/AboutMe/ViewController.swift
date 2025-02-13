//
//  ViewController.swift
//  AboutMe
//
//  Created by Куаныш Спандияр on 05.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let photoScrollView = UIScrollView()
    let stackView = UIStackView()
    var currentIndex = 0
    
    var friendsTimer: Timer?
    let friendsScrollView = UIScrollView()
    let friendsStackView = UIStackView()
    var friendsCurrentIndex = 0
    
    let imageNames = ["meshit2", "city", "park", "meshit", "mountain", "sky", "meshit1", "mountain3",]
    
    let imageNames2 = ["zhan", "uni", "dos1", "dos3", "dos6", "uni1", "dos2", "dos5", "dos7", "dos4"]
    
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground

        // Do any additional setup after loading the view.
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Important: Match the width of the contentView to the scrollView's width
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2033)
            
        ])
        
        
        let introLabel = UILabel()
        introLabel.text = "Hello!"
        introLabel.font = UIFont(name: "Rockwell-Bold", size: 25)
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.numberOfLines = 0
        introLabel.lineBreakMode = .byWordWrapping
        
        
        let name = UILabel()
        name.text = "Name: Kuanysh"
        name.font = UIFont(name: "Rockwell-Bold", size: 25)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        
        let age = UILabel()
        age.text = "19"
        age.font = UIFont(name: "Rockwell", size: 30)
        age.translatesAutoresizingMaskIntoConstraints = false
        age.numberOfLines = 0
        age.lineBreakMode = .byWordWrapping
        
        let ageText = UILabel()
        ageText.text = "Age"
        ageText.font = UIFont(name: "Rockwell", size: 17)
        ageText.translatesAutoresizingMaskIntoConstraints = false
        ageText.numberOfLines = 0
        ageText.lineBreakMode = .byWordWrapping
        
        
        let year = UILabel()
        year.text = "3rd"
        year.font = UIFont(name: "Rockwell", size: 30)
        year.translatesAutoresizingMaskIntoConstraints = false
        year.numberOfLines = 0
        year.lineBreakMode = .byWordWrapping
        
        
        let yearText = UILabel()
        yearText.text = "Year"
        yearText.font = UIFont(name: "Rockwell", size: 17)
        yearText.translatesAutoresizingMaskIntoConstraints = false
        yearText.numberOfLines = 0
        yearText.lineBreakMode = .byWordWrapping
        
        
        let faculty = UILabel()
        faculty.text = "SITE"
        faculty.font = UIFont(name: "Rockwell", size: 30)
        faculty.translatesAutoresizingMaskIntoConstraints = false
        faculty.numberOfLines = 0
        faculty.lineBreakMode = .byWordWrapping
        
        
        let facultyText = UILabel()
        facultyText.text = "Faculty"
        facultyText.font = UIFont(name: "Rockwell", size: 17)
        facultyText.translatesAutoresizingMaskIntoConstraints = false
        facultyText.numberOfLines = 0
        facultyText.lineBreakMode = .byWordWrapping
        
        
        
        
        
        let about = UILabel()
        about.text = "Hello, I'm Kuanysh. As you can see, I am 19 years old, and currently studying at the KBTU. I will introduce myself using this app. Scroll down to see more."
        about.font = UIFont(name: "Rockwell", size: 17)
        about.translatesAutoresizingMaskIntoConstraints = false
        about.numberOfLines = 0
        about.lineBreakMode = .byWordWrapping
        
        
        let hobbies = createCard(imageName: "mountain1")
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(openFirstScreen))
        hobbies.addGestureRecognizer(tapGesture1)
        hobbies.isUserInteractionEnabled = true
        
        let goals = createCard(imageName: "park1")
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(openSecondScreen))
        goals.addGestureRecognizer(tapGesture2)
        goals.isUserInteractionEnabled = true
        
        let hobbieText = UILabel()
        hobbieText.text = "Hobbies"
        hobbieText.textColor = .white
        hobbieText.font = UIFont(name: "Rockwell", size: 25)
        hobbieText.translatesAutoresizingMaskIntoConstraints = false
        hobbieText.numberOfLines = 0
        hobbieText.lineBreakMode = .byWordWrapping
        
        let goalText = UILabel()
        goalText.text = "Goals"
        goalText.textColor = .white
        goalText.font = UIFont(name: "Rockwell", size: 25)
        goalText.translatesAutoresizingMaskIntoConstraints = false
        goalText.numberOfLines = 0
        goalText.lineBreakMode = .byWordWrapping
        
        
        
        
        
        
        
        let photoText = UILabel()
        photoText.text = "Photos"
        photoText.font = UIFont(name: "Rockwell", size: 25)
        photoText.translatesAutoresizingMaskIntoConstraints = false
        photoText.numberOfLines = 0
        photoText.lineBreakMode = .byWordWrapping
        
        
        
        
        contentView.addSubview(introLabel)
        contentView.addSubview(name)
        contentView.addSubview(age)
        contentView.addSubview(ageText)
        contentView.addSubview(year)
        contentView.addSubview(yearText)
        contentView.addSubview(faculty)
        contentView.addSubview(facultyText)
        contentView.addSubview(about)
        contentView.addSubview(photoText)
        
        contentView.addSubview(hobbies)
        contentView.addSubview(goals)
        contentView.addSubview(hobbieText)
        contentView.addSubview(goalText)
        

        
        
        
        NSLayoutConstraint.activate([
            
            introLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            introLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            introLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
            
           
            
            name.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 40),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 150),
            name.widthAnchor.constraint(equalToConstant: 250),
            
            
            age.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            age.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 150),
            
            ageText.topAnchor.constraint(equalTo: age.bottomAnchor, constant: 10),
            ageText.leadingAnchor.constraint(equalTo: age.leadingAnchor, constant: 0),
            
            
            year.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            year.leadingAnchor.constraint(equalTo: age.trailingAnchor, constant: 30),
            
            
            yearText.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10),
            yearText.leadingAnchor.constraint(equalTo: year.leadingAnchor, constant: 0),
            
            
            faculty.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            faculty.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 30),
            
            
            facultyText.topAnchor.constraint(equalTo: faculty.bottomAnchor, constant: 10),
            facultyText.leadingAnchor.constraint(equalTo: faculty.leadingAnchor, constant: 0),
            
            
            
            about.topAnchor.constraint(equalTo: yearText.bottomAnchor, constant: 30),
            about.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            about.widthAnchor.constraint(equalToConstant: 350),
            about.heightAnchor.constraint(equalToConstant: 100),
            
            
            photoText.topAnchor.constraint(equalTo: hobbies.bottomAnchor, constant: 30),
            photoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            
            hobbies.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 25),
            hobbies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hobbies.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.42),
            hobbies.heightAnchor.constraint(equalToConstant: 80),
            
            goals.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 25),
            goals.leadingAnchor.constraint(equalTo: hobbies.trailingAnchor, constant: 20),
            goals.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            goals.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.42), // 40% of screen width
            goals.heightAnchor.constraint(equalToConstant: 80),
            
            
            
            hobbieText.centerXAnchor.constraint(equalTo: hobbies.centerXAnchor),
            hobbieText.centerYAnchor.constraint(equalTo: hobbies.centerYAnchor),

            goalText.centerXAnchor.constraint(equalTo: goals.centerXAnchor),
            goalText.centerYAnchor.constraint(equalTo: goals.centerYAnchor),


        ])
        
        
        let imageCircle = UIImageView(image: UIImage(named: "me2"))
        imageCircle.translatesAutoresizingMaskIntoConstraints = false
        imageCircle.clipsToBounds = true
        imageCircle.contentMode = .scaleAspectFill
        imageCircle.layer.cornerRadius = 10
        contentView.addSubview(imageCircle)
        
        
        
        NSLayoutConstraint.activate([
            imageCircle.topAnchor.constraint(equalTo: name.topAnchor, constant: 0),
            imageCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageCircle.widthAnchor.constraint(equalToConstant: 105),
            imageCircle.heightAnchor.constraint(equalToConstant: 105),
            
            
            ])
        
        
        
        
        let photoCard = createCard(imageName: "me")
        let photoCard1 = createCard(imageName: "me1")
        let photoCard2 = createCard(imageName: "friends")
        let photoCard3 = createCard(imageName: "friends1")
        contentView.addSubview(photoCard)
        contentView.addSubview(photoCard1)
        contentView.addSubview(photoCard2)
        contentView.addSubview(photoCard3)
    
        NSLayoutConstraint.activate([
            photoCard.topAnchor.constraint(equalTo: photoText.bottomAnchor, constant: 25),
            photoCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoCard.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.42),
            photoCard.heightAnchor.constraint(equalTo: photoCard.widthAnchor, multiplier: 1.2),

            photoCard1.topAnchor.constraint(equalTo: photoText.bottomAnchor, constant: 25),
            photoCard1.leadingAnchor.constraint(equalTo: photoCard.trailingAnchor, constant: 20),
            photoCard1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            photoCard1.widthAnchor.constraint(equalTo: photoCard.widthAnchor),
            photoCard1.heightAnchor.constraint(equalTo: photoCard1.widthAnchor, multiplier: 0.9),

            photoCard2.topAnchor.constraint(equalTo: photoCard1.bottomAnchor, constant: 20),
            photoCard2.leadingAnchor.constraint(equalTo: photoCard1.leadingAnchor),
            photoCard2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            photoCard2.widthAnchor.constraint(equalTo: photoCard1.widthAnchor),
            photoCard2.heightAnchor.constraint(equalTo: photoCard2.widthAnchor, multiplier: 1.2),

            photoCard3.topAnchor.constraint(equalTo: photoCard.bottomAnchor, constant: 20),
            photoCard3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoCard3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            photoCard3.widthAnchor.constraint(equalTo: photoCard.widthAnchor),
            photoCard3.heightAnchor.constraint(equalTo: photoCard3.widthAnchor, multiplier: 0.9)
        ])

        
        
        let city = UILabel()
        city.text = "My hometown is Shymkent, which is the third megapolis of Kazakhstan. It is located in the southern part of the country, so its climate is really warm. The city is surrounded by mountains, so there is a lot of greenery."
        city.font = UIFont(name: "Rockwell", size: 17)
        city.translatesAutoresizingMaskIntoConstraints = false
        city.numberOfLines = 0
        city.lineBreakMode = .byWordWrapping
        
        let cityText = UILabel()
        cityText.text = "Shymkent City📍"
        cityText.font = UIFont(name: "Rockwell", size: 25)
        cityText.translatesAutoresizingMaskIntoConstraints = false
        cityText.numberOfLines = 0
        cityText.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(city)
        contentView.addSubview(cityText)
        
        
        NSLayoutConstraint.activate([
            city.topAnchor.constraint(equalTo: photoCard3.bottomAnchor, constant: 20),
            city.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            city.widthAnchor.constraint(equalToConstant: 350),
            city.heightAnchor.constraint(equalToConstant: 130),
            
            
            cityText.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 20),
            cityText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            
        ])
        
        
        photoScrollView.translatesAutoresizingMaskIntoConstraints = false
        photoScrollView.isPagingEnabled = true
        photoScrollView.showsHorizontalScrollIndicator = false
        photoScrollView.layer.cornerRadius = 25
        photoScrollView.clipsToBounds = true
        contentView.addSubview(photoScrollView)
        
        NSLayoutConstraint.activate([
            photoScrollView.topAnchor.constraint(equalTo: cityText.bottomAnchor, constant: 20),
            photoScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            photoScrollView.heightAnchor.constraint(equalToConstant: 300)
        ])

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        photoScrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoScrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: photoScrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: photoScrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: photoScrollView.heightAnchor)
        ])
        
        
        
        
        
        setupImages()
        startAutoScroll()
        
        
        let friendsText = UILabel()
        friendsText.text = "Friends"
        friendsText.font = UIFont(name: "Rockwell", size: 25)
        friendsText.translatesAutoresizingMaskIntoConstraints = false
        friendsText.numberOfLines = 0
        friendsText.lineBreakMode = .byWordWrapping
        
        
        let friends = UILabel()
        friends.text = "Friends are the people who brighten our lives with their laughter, support, and companionship. In this app, you can easily stay connected with those who matter most. Whether it's sharing memories, staying updated, or simply chatting, our friends bring joy to every moment. "
        friends.font = UIFont(name: "Rockwell", size: 17)
        friends.translatesAutoresizingMaskIntoConstraints = false
        friends.numberOfLines = 0
        friends.lineBreakMode = .byWordWrapping
        
        let thanks = UILabel()
        thanks.text = "Thank you for Attention!"
        thanks.font = UIFont(name: "Rockwell", size: 30)
        thanks.translatesAutoresizingMaskIntoConstraints = false
        thanks.numberOfLines = 0
        thanks.lineBreakMode = .byWordWrapping
        
        
        contentView.addSubview(friendsText)
        contentView.addSubview(friends)
        contentView.addSubview(thanks)
        
        
        NSLayoutConstraint.activate([
            
            friendsText.topAnchor.constraint(equalTo: photoScrollView.bottomAnchor, constant: 30),
            friendsText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            friends.topAnchor.constraint(equalTo: friendsText.bottomAnchor, constant: 20),
            friends.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            friends.widthAnchor.constraint(equalToConstant: 350),
            friends.heightAnchor.constraint(equalToConstant: 150),

            
            
        ])
        
        friendsScrollView.translatesAutoresizingMaskIntoConstraints = false
        friendsScrollView.isPagingEnabled = true
        friendsScrollView.showsHorizontalScrollIndicator = false
        friendsScrollView.layer.cornerRadius = 25
        friendsScrollView.clipsToBounds = true
        contentView.addSubview(friendsScrollView)
        
        NSLayoutConstraint.activate([
            friendsScrollView.topAnchor.constraint(equalTo: friends.bottomAnchor, constant: 20),
            friendsScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            friendsScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            friendsScrollView.heightAnchor.constraint(equalToConstant: 300),
            
            
            thanks.topAnchor.constraint(equalTo: friendsScrollView.bottomAnchor, constant: 30),
            thanks.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
        ])
        
        
        
        friendsStackView.axis = .horizontal
        friendsStackView.distribution = .fillEqually
        friendsStackView.translatesAutoresizingMaskIntoConstraints = false
        friendsScrollView.addSubview(friendsStackView)
        
        NSLayoutConstraint.activate([
            friendsStackView.topAnchor.constraint(equalTo: friendsScrollView.topAnchor),
            friendsStackView.leadingAnchor.constraint(equalTo: friendsScrollView.leadingAnchor),
            friendsStackView.trailingAnchor.constraint(equalTo: friendsScrollView.trailingAnchor),
            friendsStackView.bottomAnchor.constraint(equalTo: friendsScrollView.bottomAnchor),
            friendsStackView.heightAnchor.constraint(equalTo: friendsScrollView.heightAnchor)
        ])
        
        setupFriendsImages()
        
        
        
        
        
        
    }
    
    func createCard(imageName: String) -> UIView {
        
        let cardView = UIView()
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2  //0.3
        cardView.layer.shadowRadius = 1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        cardView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
        
        
        return cardView
        
    }
    

    func setupImages() {
        for imageName in imageNames {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: photoScrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: photoScrollView.heightAnchor)
            ])
        }
    }
    
    func setupFriendsImages() {
        for imageName in imageNames2 {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            friendsStackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: friendsScrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: friendsScrollView.heightAnchor)
            ])
        }
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }
    
    func startFriendsAutoScroll() {
        friendsTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollFriendsToNext), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNext() {
        let nextIndex = (currentIndex + 1) % imageNames.count
        let offsetX = CGFloat(nextIndex) * photoScrollView.frame.width
        
        UIView.animate(withDuration: 0.5, animations: {
            self.photoScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        })
        
        currentIndex = nextIndex
    }
    
    @objc func scrollFriendsToNext() {
        let nextIndex = (friendsCurrentIndex + 1) % imageNames2.count
        let offsetX = CGFloat(nextIndex) * friendsScrollView.frame.width
        
        UIView.animate(withDuration: 0.5, animations: {
            self.friendsScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        })
        
        friendsCurrentIndex = nextIndex
    }
    
    deinit {
        timer?.invalidate()
        friendsTimer?.invalidate()
    }
    
    
    @objc func openFirstScreen() {
        let firstScreen = HobbiesViewController()
        navigationController?.pushViewController(firstScreen, animated: true)
    }

    @objc func openSecondScreen() {
        let secondScreen = GoalsViewController()
        navigationController?.pushViewController(secondScreen, animated: true)
    }
    
    
}






