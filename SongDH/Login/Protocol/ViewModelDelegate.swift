//
//  ViewModelDelegate.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func willLoadData()
    func didLoadData()
    func didLoadDataFailedWith(_ error: Error?)
}
