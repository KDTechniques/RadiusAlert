//
//  ReadMeView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-01.
//

import SwiftUI

struct ReadMeView: View {
    // MARK: - INJECTED PROPERTIES
    @Binding var isPresented: Bool
    
    // MARK: - INITIALIZER
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .onTapGesture { isPresented.toggle() }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(25)
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 50) {
                    appNameNDescription
                    why
                    keyFeatures
                    howItWorks
                    uxChoices
                }
                .padding(.horizontal, 50)
                .padding(.top, 110)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .presentationCornerRadius(40)
    }
}

// MARK: - PREVIEWS
#Preview("Read Me") {
    @Previewable @State var isPresented: Bool = true
    
    //    Color.clear
    //        .sheet(isPresented: $isPresented) {
    ReadMeView(isPresented: $isPresented)
    //        }
    //        .previewModifier()
}

// MARK: - EXTENSIONS
extension  ReadMeView {
    private func titleText(_ text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
        
    }
    
    private func subTitleText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    private func descriptionText(_ text: String) -> some View {
        Text(text)
            .fontWeight(.semibold)
    }
    
    private func bulletEmojiText(_ item: BulletTextModel) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(item.emoji)
            Text(item.text)
        }
    }
    
    private func bulletText(_ text: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(text)
        }
        .fontWeight(.semibold)
    }
    
    private func bulletTextForEach(_ items: [BulletTextModel]) -> some View {
        VStack(alignment:  .leading, spacing: 8) {
            ForEach(items) {
                bulletEmojiText($0)
            }
        }
        .fontWeight(.medium)
        .foregroundStyle(.secondary)
    }
    
    private var appNameNDescription:  some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Radius Alert")
                .font(.largeTitle.weight(.heavy))
            
            Text("Radius Alert is an iOS app designed to solve a simple but common problem: falling asleep or getting distracted during your bus or train ride — and missing your stop.")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
    
    private var why: some View {
        VStack(alignment: .leading, spacing: 5) {
            titleText("🚌 Why Radius Alert?")
            
            descriptionText("If you’ve ever dozed off or gotten lost in your iPhone on a commute, you know the fear:\n")
            
            let bullets: [BulletTextModel] = [
                .init(emoji: "😴", text: "Falling asleep during your ride."),
                .init(emoji: "😨", text: "Missing your stop."),
                .init(emoji: "🚶‍♂️", text: "Having to walk (or pay extra) just to get back.")
            ]
            
            bulletTextForEach(bullets)
            
            descriptionText("\nRadius Alert takes that stress away. Just set your stop, relax, listen to music, even take a nap — and the app will wake you up right on time.")
        }
    }
    
    private var keyFeatures: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("✨ Key Features")
            VStack(alignment: .leading, spacing: 40) {
                keyFeature1
                keyFeature2
                keyFeature3
                keyFeature4
                keyFeature5
            }
        }
    }
    
    private var keyFeature1: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🎯 Smart Radius Alerts")
            bulletText("Pick your stop on the map or search for a location.")
            bulletText("Use the slider to set your custom radius — as small or as large as you want.")
            
            VStack(alignment:  .leading,  spacing: 5) {
                bulletText("When you enter your chosen radius, the app alerts you with:\n")
                
                VStack(alignment: .leading, spacing: 10) {
                    let items: [BulletTextModel] = [
                        .init(emoji: "🚨", text: "Push notification"),
                        .init(emoji: "📳", text: "Haptic feedback"),
                        .init(emoji: "🔔", text: "Your chosen alert tone"),
                        .init(emoji: "📲", text: "On-screen popup\n")
                    ]
                    
                    bulletTextForEach(items)
                }
                .padding(.leading, 40)
                
                bulletText("Note: Haptics (vibration) only trigger if your iPhone is unlocked.")
            }
        }
    }
    
    private var keyFeature2: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("💤 Carefree Commuting")
            bulletText("Nap, read, listen to music, or scroll TikTok worry-free.")
            bulletText("The app runs quietly in the background and won’t interrupt your music — instead, it smoothly lowers the volume, plays the alert sound, and then restores your audio.")
        }
    }
    
    private var keyFeature3: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🔋 Battery-Friendly by Design")
            bulletText("Location updates are optimized for minimal battery drain.")
            bulletText("When your iPhone is locked, the app avoids unnecessary activity and only focuses on delivering accurate alerts.")
        }
    }
    
    private var keyFeature4: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🚫 Distraction-Free")
            bulletText("No ads.")
            bulletText("No clutter.")
            bulletText("A clean, simple interface focused only on your journey.")
            bulletText("Dark Mode supported for comfortable night use.")
        }
    }
    
    private var keyFeature5: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🎵 More Control for You")
            bulletText("Choose your own alert tone.")
            bulletText("You decide if and when notifications are allowed — nothing happens without your consent.")
        }
    }
    
    private var howItWorks: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("⚙️ How It Works")
            
            VStack(alignment: .leading, spacing: 5) {
                subTitleText("1. Pick a Destination")
                bulletText("Search for your stop or drop a pin on the map.")
            }
            
            VStack(alignment: .leading, spacing: 5) {
                subTitleText("2. Set Your Radius")
                bulletText("Choose how close you want to be notified (e.g., 700m, 1km).")
            }
            
            VStack(alignment: .leading, spacing: 5) {
                subTitleText("3. Relax and Ride")
                bulletText("Put your iPhone away and enjoy your trip.")
                bulletText("You can still listen to music or podcasts — the app will gently pause the noise when it’s time to alert you.")
            }
            
            VStack(alignment: .leading, spacing: 5) {
                subTitleText("4. Get Notified")
                bulletText("As soon as you reach your set radius, you’ll be alerted by:\n")
                
                VStack(alignment: .leading, spacing: 10) {
                    let items: [BulletTextModel] = [
                        .init(emoji: "🚨", text: "Push notification"),
                        .init(emoji: "📳", text: "Haptic feedback "),
                        .init(emoji: "🔔", text: "Your chosen alert tone"),
                        .init(emoji: "📲", text: "On-screen popup\n")
                    ]
                    
                    bulletTextForEach(items)
                }
                .padding(.leading, 40)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                subTitleText("5. Stay in Control")
                bulletText("Stop or adjust alerts anytime with a single tap.")
                
            }
        }
    }
    
    private var uxChoices: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("🧩 UX Choices That Matter")
            
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 10) {
                    subTitleText("📲 Alert Popup")
                    bulletText("When you arrive, the popup shows useful details at a glance:\n")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        let items: [BulletTextModel] = [
                            .init(emoji: "📍", text: "Destination name"),
                            .init(emoji: "📏", text: "Distance traveled"),
                            .init(emoji: "🎯", text: " Your chosen radius"),
                            .init(emoji: "⏱️", text: "Time it took")
                        ]
                        
                        bulletTextForEach(items)
                    }
                    .padding(.leading, 40)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    subTitleText("🧠 Memory-Friendly")
                    bulletText("The live map is removed when not needed, keeping the app light — using only about 0–1% of your phone’s processing power and around 150MB of memory.")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    subTitleText("🛡️ User-First Approach")
                    bulletText("You’re only asked for notification permission when you actually need it.")
                    bulletText("Map interactions are limited once an alert is active, preventing unnecessary battery or memory usage.")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    subTitleText("Radius Alert lets you travel with peace of mind. ⚡")
                    
                    Text("No stress. No missed stops. Just set it, forget it, and ride worry-free.")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

fileprivate struct BulletTextModel: Identifiable {
    let id: String = UUID().uuidString
    let emoji: String
    let text: String
}
