//
//  Coordinator.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 18/05/2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
