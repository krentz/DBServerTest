//
//  UIImageView+LoadImage.swift
//  DBServerTest
//
//  Created by Rafael Krentz Gonçalves on 7/1/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

extension UIImageView {
    public func loadImage(url: String) {
        var kf = self.kf
        kf.cancelDownloadTask()
        kf.indicatorType = .activity
        kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "placeholder"),
            options: [.transition(.fade(0.2))] )
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
