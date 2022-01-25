//
//  CategoriesPicker.swift
//  VKApp
//
//  Created by Denis Kuzmin on 11.04.2021.
//

import UIKit

class RatingView: UIControl {

    var rating: Int = 0
    
    @IBInspectable var buttonsNumber: Int = 5
    private var buttons = [UIButton]()
    private var stackView: UIStackView?
    
    // MARK: - Initializers
    
    init(frame: CGRect, buttonsNumber: Int) {
        self.buttonsNumber = buttonsNumber
        super.init(frame: frame)
        setUpView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = bounds
    }
    
    func setRating(rating: Int) {
        self.rating = rating
        guard rating > 0 && rating <= buttonsNumber else { return }
        for count in 0 ... rating - 1 {
            buttons[count].setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        guard rating < buttonsNumber else { return }
        for count in rating ... buttonsNumber - 1 {
            buttons[count].setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        rating = sender.tag + 1
        setRating(rating: rating)
        sendActions(for: .valueChanged)
    }
    
    
    private func makeButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: .touchUpInside)
        button.tag = tag
        return button
    }
    
    private func setUpView() {
        backgroundColor = .clear
        guard buttonsNumber > 0 else { return }
        for count in 0 ... buttonsNumber - 1 {
            let button = makeButton(tag: count)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView?.frame = bounds
        stackView!.backgroundColor = .clear
        addSubview(stackView!)
        stackView!.axis = .horizontal
        stackView!.alignment = .center
        stackView!.distribution = .fillEqually
        setRating(rating: 0)
    }
    

}
