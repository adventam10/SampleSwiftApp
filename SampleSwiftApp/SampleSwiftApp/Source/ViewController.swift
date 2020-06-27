//
//  ViewController.swift
//  SampleSwiftApp
//
//  Created by am10 on 2020/06/20.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
 
final class ViewController: UIViewController {
    private let resolver = AppResolverImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 起動時に画面を差し替える場合はここで設定する
        showStartViewController()
    }

    private func showStartViewController() {
        let rootViewController = R.storyboard.start.instantiateInitialViewController()!
        let start = rootViewController.viewControllers.first as! StartViewController
        start.presentationModel = resolver.resolveStartPresentationModel()
        view.addSubview(rootViewController.view)
        addChild(rootViewController)
        rootViewController.didMove(toParent: self)
    }
}
