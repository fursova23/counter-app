//
//  ViewController.swift
//  Counter
//
//  Created by Elena Fursova on 07.12.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var count: Int = 0
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decreaseButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var historyView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Применяем стиль ко всем кнопкам
        [incrementButton, decreaseButton, clearButton].forEach { button in
            configureButtonStyle(button)
        }
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        count += 1
        updateLabel()
        logChange(operation: .increment)
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        let newVal: Int = count - 1
        
        if newVal >= 0 {
            count = newVal
            updateLabel()
            logChange(operation: .decrease)
        } else {
            logChange(operation: .failedDecrease)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        count = 0
        updateLabel()
        logChange(operation: .clear)

    }
    
    private func updateLabel() {
        counterLabel.text = "Значение счетчика: \(count)"
    }
    
    private func logChange(operation: Operation) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        
        let dateString = formatter.string(from: Date())
        
        let logMessage: String
        switch operation {
        case .increment:
            logMessage = "\(dateString): значение изменено на +1"
        case .decrease:
            logMessage = "\(dateString): значение изменено на -1"
        case .clear:
            logMessage = "\(dateString): значение сброшено"
        case .failedDecrease:
            logMessage = "\(dateString): попытка уменьшить значение счётчика ниже 0"
        }
        
        historyView.text += "\n" + logMessage
        
        // Автоскролл
        let range = NSRange(location: historyView.text.count - 1, length: 1)
        historyView.scrollRangeToVisible(range)
    }
    
    private func configureButtonStyle(_ button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
    }
    
    private enum Operation {
        case increment
        case decrease
        case clear
        case failedDecrease
    }
    
}
