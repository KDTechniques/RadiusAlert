//
//  AboutBasicInfoView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutBasicInfoView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            version
            AboutListRowView("Launch", "15th Sep 2025")
            AboutListRowView("Developer", "Paramsoodi Kavinda Dilshan")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Basic Info About Section") {
    List {
        AboutBasicInfoView()
            .previewModifier()
    }
}

// MARK: -  EXTENSIONS
extension  AboutBasicInfoView {
    @ViewBuilder
    private var version: some View {
        if let versionNBuildNumber: String = Utilities.appVersion() {
            AboutListRowView("Version", versionNBuildNumber)
        }
    }
}
