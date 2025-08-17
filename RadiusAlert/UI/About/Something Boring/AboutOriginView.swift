//
//  AboutOriginView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutOriginView: View {
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            List {
                Section {
                    Text("ඔයත් bus එකේ නිදාගෙන ගිහින්, stop එක miss කරගෙන charter වෙලා තියෙනවද? 😅\n\nමං බස් එකේ වැඩට යන නිසා, මගේ ප්‍රශ්නෙ තමා, ආතල් එකේ නිදාගෙන යන්න විදිහක් නැති එක. 😴 මොකද bus stop එක miss වෙයි කියල තියෙන බය. 😨 එහෙම වුනාම ආපස්සට එන්න charter වෙන නිසා. 🚶‍♂️\n\nමට ඕන වුනේ simple දෙයක්:\n- 🪫 Battery කන්නෙ නැති\n- 📢 Ads නැති\n- 🗺️ Destination එකට circular radius range එකක් දීල, ලං වෙද්දි හරියටම alert එකක් දෙන app එකක්. 🚨\n\nඒත් App Store එකේ මට හිතට අල්ලන එක app එකක්වත් හොයාගන්න බැරි උනා. 🙅🏻‍♂️\n\nතිබ්බ හැම app එකකම වගේ functionalities and UI/UX ගොඩක් අවුල් or පට්ට චාටර්. 😾\n\nඒ නිසා මමම හදන්න පටන් ගත්තා - Radius Alert කියන iOS App එක 👨🏻‍💻\n\nBus එකේ commute කරන අතරතුර තමා develop කරගෙන යන්නෙ. 🚌")
                } header: {
                    Text("The Story Behind the App")
                }
            }
            .navigationTitle(Text("Origin"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Origin 👨🏻‍💻")
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Origin") {
    NavigationStack {
        AboutOriginView()
    }
    .previewModifier()
}
