//
//  HeadingAndSubHeadingViewSnapshotTests.swift
//  PokémonDenSnapshotTests
//
//  Created by Utkarsh Agrawal on 28/12/22.
//

import XCTest
import SwiftUI
@testable import PokémonDen
import SnapshotTesting

class HeadingAndSubHeadingViewSnapshotTests: XCTestCase {

    /*func testDefaultAppearance() {
        assertSnapshot(
            matching: HeadingAndSubHeadingView(heading: "Heading", subHeading: "Subheading").toVC(),
            as: .image)
    }*/
}

private extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
