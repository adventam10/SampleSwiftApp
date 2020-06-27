//
//  WeatherViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/21.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
import WebKit

final class WeatherViewController: UIViewController {
    var presentationModel: WeatherPresentationModel!

    @IBOutlet private weak var avatarWebView: WKWebView!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var avatarErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        avatarErrorLabel.isHidden = true
        weatherLabel.text = presentationModel.formattedWeatherText
        if presentationModel.isSaveButtonShown {
            if #available(iOS 13.0, *) {
                navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "tray.and.arrow.down.fill")!, style: .done, target: self, action: #selector(saveWeather(_:)))
            } else {
                navigationItem.rightBarButtonItem = .init(title: "保存", style: .done, target: self, action: #selector(saveWeather(_:)))
            }
        }
        presentationModel.getAvatar { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.avatarWebView.load(imageData, mimeType: "image/svg+xml",
                                        characterEncodingName: "utf-8",
                                        baseURL: URL(string: "http://localhost")!)
            case .failure(let error):
                self.avatarErrorLabel.isHidden = false
                log?.error(error.localizedDescription)
            }
        }
    }

    @objc private func saveWeather(_ sender: Any) {
        presentationModel.saveWeather()
        showAlert(message: "お天気情報を保存しました")
    }
}
