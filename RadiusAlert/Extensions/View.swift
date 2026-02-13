//
//  View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

extension View {
    /// Applies a set of modifiers for SwiftUI previews to ensure
    /// consistency in testing environments.
    ///
    /// - Returns: A modified view with light color scheme and injected dependencies.
    @ViewBuilder
    func previewModifier() ->  some View {
        @Previewable @State var settingsVM: SettingsViewModel = .init()
        @Previewable @State var mapVM: MapViewModel = .init(settingsVM: settingsVM)
        @Previewable @State var locationPinsVM: LocationPinsViewModel = .init(mapVM: mapVM)
        
        self
            .preferredColorScheme(.light)
            .environment(mapVM)
            .environment(settingsVM)
            .environment(locationPinsVM)
            .dynamicTypeSizeViewModifier
    }
    
    /// A global alert view modifier attached to the `ContentView`.
    /// Handles and presents all alert popups managed by `AlertManager`
    /// throughout the entire app lifecycle.
    @ViewBuilder
    func alertViewModifier(at level: AlertViewLevels) -> some View {
        let alertManager: AlertManager = .shared
        let firstItem: AlertModel? = alertManager.getFirstAlertItem()
        
        self
            .alert(
                firstItem?.title ?? "",
                /// isPresented: get true & false, but only setting false when dismissed by the user.
                isPresented: (level == firstItem?.viewLevel) ? alertManager.alertPopupBinding() : .constant(false),
                presenting: firstItem,
                actions: { alert in
                    ForEach(alert.actions) { action in
                        action.button
                    }
                },
                message: { alert in
                    Text(alert.message)
                }
            )
    }
    
    /// Restricts the dynamic type size of the view to a range between `.xSmall` and `.large`.
    ///
    /// This ensures that the text inside the view will scale only within this range,
    /// while still respecting accessibility settings up to the **default iPhone text size** (`.large`).
    ///
    /// Example:
    /// ```swift
    /// Text("Hello, world!")
    ///     .dynamicTypeSizeViewModifier
    /// ```
    var dynamicTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.xSmall ... .large)
    }
    
    /// Fixes the dynamic type size of the view to `.large`.
    ///
    /// `.large` corresponds to the **default text size on iPhones**.
    /// This ensures the text inside the view always renders at that default size,
    /// regardless of the user’s dynamic type settings.
    /// Useful for UI elements that require consistent sizing.
    ///
    /// Example:
    /// ```swift
    /// Text("Fixed Size")
    ///     .defaultTypeSizeViewModifier
    /// ```
    var defaultTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.large)
    }
    
    @ViewBuilder
    var mapControlButtonBackgroundViewModifier: some View {
        if #available(iOS 26.0, *) {
            self
                .background(
                    Color.primary.opacity(0.001),
                    in: .circle
                )
        } else {
            self
                .background(
                    Color.custom.Map.mapControlButtonBackground.color,
                    in: .rect(cornerRadius: 8)
                )
        }
    }
    
    var mapControlButtonShadowViewModifier: some View {
        self
            .background {
                Color.clear
                    .mapControlButtonBackgroundViewModifier
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -1, y: 1)
            }
    }
    
    func limitInputLengthViewModifier(_ binding: Binding<String>, to length: Int) -> some View {
        self
            .onChange(of: binding.wrappedValue) { _, newValue in
                if newValue.count > length {
                    binding.wrappedValue = String(newValue.prefix(length))
                }
            }
    }
    
    var mapBottomTrailingButtonsViewModifier: some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
            .padding(.bottom, 40)
            .mapBottomTrailingButtonsTrailingPadding
    }
    
    @ViewBuilder
    var sheetCornerRadiusViewModifier: some View {
        if #available(iOS 26, *) {
            self
                .presentationCornerRadius(40)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func savedLocationPinButtonBackgroundViewModifier(type: MapTypes) -> some View {
        switch type {
        case .primary:
            self.background(.regularMaterial)
            
        case .secondary:
            self.background(.clear)
        }
    }
    
    @ViewBuilder
    func savedLocationPinButtonGlassEffect(type: MapTypes, colorScheme: ColorScheme) -> some View {
        if #available(iOS  26.0, *) {
            let effect: Glass = {
                switch type {
                case .primary:
                    return .clear
                case .secondary:
                    return colorScheme == .dark ? .regular : .clear
                }
            }()
            
            self
                .glassEffect(effect)
        } else {
            self
                .overlay {
                    Capsule()
                        .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                }
        }
    }
}

// MARK: - EXTENSIONS
fileprivate extension View {
    var mapBottomTrailingButtonsTrailingPadding: some View {
        if #available(iOS 26.0, *) {
            self
                .padding(.trailing)
        } else {
            self
                .padding(.trailing, 5)
        }
    }
}

