//
//  AboutView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-12.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section {
                AboutListRowView("Version", "1.0.0")
                AboutListRowView("Launch", "15th Sep 2025")
                AboutListRowView("Developer", "Paramsoodi Kavinda Dilshan")
            }
            
            Section {
                whatsNew
                futureUpdates
            } header: {
                Text("App Improvements")
            }
            
            Section {
                origin
                connectWithDeveloper
            } header: {
                Text("Something Boring")
            } footer: {
                Text("Made with ❤️ in Sri Lanka 🇱🇰".uppercased())
                    .padding(.vertical)
            }
        }
        .navigationTitle(Text("About"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("About") {
    NavigationStack {
        AboutView()
    }
    .previewModifier()
}

struct AboutListRowView: View {
    let primaryText: String
    let secondaryText: String
    
    init(_ primaryText: String, _ secondaryText: String) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
    
    var body: some View {
        HStack {
            Text(primaryText)
            
            Spacer()
            
            Text(secondaryText)
                .foregroundStyle(.secondary)
        }
    }
}

extension AboutView{
    private var whatsNew: some View {
        NavigationLink {
            List {
                Text("• Bullet points list of what's new goes here.")
            }
            .navigationTitle(Text("What's New"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("What's New ✨")
        }
    }
    
    private var futureUpdates: some View {
        NavigationLink {
            List {
                Text("• Bullet points list of future updates goes here.")
            }
            .navigationTitle(Text("Future Updates"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Future Updates 📲")
        }
    }
    
    private var origin: some View {
        NavigationLink {
            List {
                Text("ඔයත් bus එකේ නිදාගෙන ගිහින්, stop එක miss කරගෙන charter වෙලා තියෙනවද? 😅\n\nමං බස් එකේ වැඩට යන නිසා, මගේ ප්‍රශ්නෙ තමා, ආතල් එකේ නිදාගෙන යන්න විදිහක් නැති එක. 😴 මොකද bus stop එක miss වෙයි කියල තියෙන බය. 😨 එහෙම වුනාම ආපස්සට එන්න charter වෙන නිසා. 🚶‍♂️\n\nමට ඕන වුනේ simple දෙයක්:\n- 🪫 Battery කන්නෙ නැති\n- 📢 Ads නැති\n- 🗺️ Destination එකට circular radius range එකක් දීල, ලං වෙද්දි හරියටම alert එකක් දෙන app එකක්. 🚨\n\nඒත් App Store එකේ මට හිතට අල්ලන එක app එකක්වත් හොයාගන්න බැරි උනා. 🙅🏻‍♂️තිබ්බ හැම app එකකම වගේ functionalities and UI/UX ගොඩක් අවුල් or පට්ට චාටර්. 😾ඒ නිසා මමම හදන්න පටන් ගත්තා — Radius Alert කියන iOS App එක👨🏻‍💻Bus එකේ commute කරන අතරතුර තමා develop කරගෙන යන්නෙ.")
            }
            .navigationTitle(Text("Origin"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Origin 👨🏻‍💻")
        }
    }
    
    private var connectWithDeveloper: some View {
        NavigationLink {
            List {
                Text("Public info goes here...")
            }
            .navigationTitle(Text("Connect with Kavinda"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Connect with Kavinda 👋")
        }
    }
}
