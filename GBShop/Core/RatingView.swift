//
//  CategoriesPicker.swift
//  VKApp
//
//  Created by Denis Kuzmin on 11.04.2021.
//

import UIKit

class RatingView: UIControl {

    @IBInspectable var buttonsNumber: Int = 5

    
    var symbolHeight: CGFloat = 30.0 //Высота символа категории
    
    // MARK: - Properties
    
    var categories = [String]() {
        didSet {
            setNeedsLayout()
        }
    }
    var pickedCategory: Int = 0
    
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
    
    // MARK: - Overrided methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = bounds
    }
    
    func setRating(rating: Int) {
        guard rating > 0 && rating <= buttonsNumber else { return }
        for count in 0 ... rating - 1 {
            buttons[count].setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        guard rating < buttonsNumber else { return }
        for count in rating ... buttonsNumber - 1 {
            buttons[count].setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    // MARK: - Private methods
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        let rating = sender.tag + 1
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
