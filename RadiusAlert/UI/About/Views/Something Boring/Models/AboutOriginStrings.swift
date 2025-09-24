//
//  AboutOriginStrings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-21.
//

import Foundation

enum AboutOriginStrings {
    case forSriLankans, other
    
    static func getOriginString() -> String {
        return Utilities.isCountryCodeSriLanka() ? Self.forSriLankans.string : Self.other.string
    }
    
    private var string: String {
        switch self {
        case .forSriLankans:
            return "ඔයත් bus එකේ නිදාගෙන ගිහින්, stop එක miss කරගෙන charter වෙලා තියෙනවද? 😅\n\nමං බස් එකේ වැඩට යන නිසා, මගේ ප්‍රශ්නෙ තමා, ආතල් එකේ නිදාගෙන යන්න විදිහක් නැති එක. 😴 මොකද bus stop එක miss වෙයි කියල තියෙන බය. 😨 එහෙම වුනාම ආපස්සට එන්න charter වෙන නිසා. 🚶‍♂️\n\nමට ඕන වුනේ simple දෙයක්:\n- 🪫 Battery කන්නෙ නැති\n- 📢 Ads නැති\n- 🗺️ Destination එකට circular radius range එකක් දීල, ලං වෙද්දි හරියටම alert එකක් දෙන app එකක්. 🚨\n\nඒත් App Store එකේ මට හිතට අල්ලන එක app එකක්වත් හොයාගන්න බැරි උනා. 🙅🏻‍♂️\n\nතිබ්බ හැම app එකකම වගේ functionalities and UI/UX ගොඩක් අවුල් or පට්ට චාටර්. 😾\n\nඒ නිසා මමම හදන්න පටන් ගත්තා - Radius Alert කියන iOS App එක 👨🏻‍💻\n\nBus එකේ commute කරන අතරතුර තමා develop කරගෙන යන්නෙ. 🚌"
            
        case .other:
            return "Have you ever fallen asleep on the bus and ended up missing your stop, getting dragged way past where you needed to get off? 😅\n\nThat’s my biggest problem when commuting. Since I take the bus to work, I can’t just relax or nap. 😴 There’s always that fear of overshooting my stop. 😨 And when it happens, I have to walk all the way back. 🚶‍♂️\n\n All I wanted was something simple:\n- 🪫 Doesn’t drain my battery\n- 📢 No annoying ads\n- 🗺️ Lets you set a circular radius around your destination and gives you a precise alert when you’re getting close 🚨\n\nBut I couldn’t find a single app on the App Store that really does this. 🙅🏻‍♂️ \n\nEvery app I tried either had clunky features, terrible UI/UX, or just didn’t work properly. 😾\n\nSo I decided to build it myself — an iOS app called Radius Alert. 👨🏻‍💻\n\nI’ve been developing it during my daily bus commutes. 🚌"
        }
    }
}
