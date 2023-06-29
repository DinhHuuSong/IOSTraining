//
//  ViewModelDelegate.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

protocol LoginModelDelegate: AnyObject {
    func willLogin()
    func didLogin()
    func didLoginFailedWith(_ error: Error?)
}
