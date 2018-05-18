//
//  NibIdentifiable.swift
//  ZhihuDaily
//
//  Created by 郑尧元 on 2018/5/11.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {

    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIView: NibIdentifiable {

    static var nibIdentifier: String {
        return String(describing: self)
    }

}

extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibIdentifiable where Self: UIView {

    static func instantiateFromNib() -> Self {
        guard let view = UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(String(describing: Self.self))") }
        return view
    }

}

extension NibIdentifiable where Self: UIViewController {

    static func instantiateFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }
}

extension NibIdentifiable where Self: UITableView {

    static func instantiateFromNib() -> Self {
        guard let tableView = UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(String(describing: Self.self))") }
        return tableView
    }

}

extension UITableView {

    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(T.nib, forCellReuseIdentifier: String(describing: T.self))
    }

    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
            else { fatalError("Couldn't find nib file for \(String(describing: T.self))") }
        return cell
    }

    func dequeueResuableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
            else { fatalError("Couldn't find nib file for \(String(describing: T.self))") }
        return cell
    }

    func dequeueResuableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
            else { fatalError("Couldn't find nib file for \(String(describing: T.self))") }
        return headerFooterView
    }

}