//
//  Instantiation.swift
//  oneApp
//
//  Created by Aleksei Tsyss on 13/02/2019.
//  Copyright © 2019 Consumer Reports. All rights reserved.
//

import UIKit
import SwiftExceptionCatcher

protocol Instantiatable {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    static func instantiate(with viewModel: ViewModel) -> Self
}

extension Instantiatable where Self: UIViewController {

    static func instantiate(with viewModel: Self.ViewModel) -> Self {
        let storyboardId = String(describing: self)

        guard let genericViewContoller = UIStoryboard.getGenericViewController(with: storyboardId),
            var vc = genericViewContoller as? Self else {
            fatalError("Failed to instantiate '\(storyboardId)'")
        }

        vc.viewModel = viewModel
        return vc
    }

}

extension FileManager {

    private static let enumeratorForAllFiles: FileManager.DirectoryEnumerator? = {
        guard let directory = Bundle.main.resourcePath,
            let enumerator = FileManager.default.enumerator(atPath: directory) else {
                return nil
        }

        return enumerator
    }()

    static let allFiles: Set<String> = {
        var files: Set<String> = Set()
        while let element = enumeratorForAllFiles?.nextObject() as? String {
            files.insert(element)
        }
        return files
    }()

}

extension UIStoryboard {

    static let all: [UIStoryboard] = FileManager.allFiles
        .filter { $0.hasSuffix(".storyboardc") }
        .map { URL(fileURLWithPath: $0).deletingPathExtension().lastPathComponent }
        .map { UIStoryboard(name: $0, bundle: nil) }

    static var cache: [String: UIStoryboard] = [:]

    static func getGenericViewController(with storyboardId: String) -> UIViewController? {
        if let storyboard = cache[storyboardId] {
            return storyboard.instantiateViewController(withIdentifier: storyboardId)
        }

        for storyboard in all {
            if let vc = try? tryOp({ storyboard.instantiateViewController(withIdentifier: storyboardId) }) {
                cache[storyboardId] = storyboard
                return vc
            }
        }

        return nil
    }

}
