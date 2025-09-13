//
//  ReadMeView_EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

protocol ReadMeComponents { }


extension ReadMeComponents {
    func titleText(_ text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
    
    func subTitleText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    func descriptionText(_ text: String) -> some View {
        Text(text)
            .fontWeight(.semibold)
    }
    
    func bulletEmojiText(_ item: BulletTextModel) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(item.emoji)
            Text(item.text)
        }
    }
    
    func bulletText(_ text: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(text)
        }
        .fontWeight(.semibold)
    }
    
    func bulletTextForEach(_ items: [BulletTextModel]) -> some View {
        VStack(alignment:  .leading, spacing: 8) {
            ForEach(items) {
                bulletEmojiText($0)
            }
        }
        .fontWeight(.medium)
        .foregroundStyle(.secondary)
    }
}

extension View {
    var readMeHeading1ViewModifier: some View {
        self
            .font(.title)
            .fontWeight(.bold)
    }
    
    var readMeHeading2ViewModifier: some View {
        self
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var readMeBodyViewModifier: some View {
        self
            .foregroundStyle(.secondary)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    var afterScrollTargetLayoutViewModifier: some View {
        self
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
    }
    
    var headingSectionToSectionPadding: some View {
        self
            .padding(.top, 50)
    }
}
