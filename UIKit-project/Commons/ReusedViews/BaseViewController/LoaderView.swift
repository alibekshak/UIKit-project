//
//  LoaderView.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 02.12.2025.
//

import UIKit

class LoaderView: UIView {
    
    // MARK: - UI
    
    private let loaderImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.2.circlepath")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func startAnimation() {
        guard self.loaderImageView.layer.animation(forKey: "spin") == nil else { return }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        self.loaderImageView.layer.add(rotation, forKey: "spin")
        
        UIView.animate(withDuration: 0.25) {
            self.blurEffectView.alpha = 1.0
            self.alpha = 1.0
        }
    }
    
    func stopAnimation() {
        self.loaderImageView.layer.removeAnimation(forKey: "spin")
        
        UIView.animate(withDuration: 0.25, animations: {
            self.blurEffectView.alpha = 0.0
            self.alpha = 0.0
        })
    }
    
    // MARK: - Private methods
    
    private func setup() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubview(blurEffectView)
        addSubview(loaderImageView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loaderImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loaderImageView.widthAnchor.constraint(equalToConstant: 44),
            loaderImageView.heightAnchor.constraint(equalTo: loaderImageView.widthAnchor)
        ])
    }
}
