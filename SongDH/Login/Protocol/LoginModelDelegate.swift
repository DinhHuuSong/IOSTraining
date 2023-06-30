//
//  ViewModelDelegate.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

protocol LoginModelDelegate: AnyObject {
    // Notify delegate that login will start
    func willLogin()

    // Notify delegate that login was successful
    func didLogin()

    // Notify delegate that login failed with a certain error
    func didLoginFailedWith(_ error: Error?)
}
