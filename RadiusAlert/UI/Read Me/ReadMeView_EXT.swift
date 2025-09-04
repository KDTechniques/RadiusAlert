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
