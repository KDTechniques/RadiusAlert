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
    /// - Returns: A modified view with light color scheme, controlled type size, and injected dependencies.
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
    /// This bypasses `dynamicTypeSizeViewModifier`, even if it allows a range
    /// between `.xSmall` and `.large`, and forces the view to remain at `.large`.
    ///
    /// `.large` corresponds to the default text size on iPhone.
    /// This ensures the content always renders at a consistent size,
    /// regardless of the user’s dynamic type settings.
    ///
    /// Useful for UI elements with tight layout constraints where scaling
    /// could break the design (e.g. buttons in limited space).
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
    
    /// Any button overlay placed on the map must match the defined view modifier protocols.
    /// This means we avoid applying custom button backgrounds directly,
    /// as they should align with the map button background styling conventions.
    /// To keep the UI clean and consistent, this modifier is applied to all map overlay buttons,
    /// matching the default button styles used in Apple map views.
    @ViewBuilder
    var mapOverlayButtonBackgroundViewModifier: some View {
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
    
    /// Any button overlay placed on the map must match the defined view modifier protocols.
    /// This ensures consistency with the map button background styling conventions.
    ///
    /// This modifier applies an invisible background to maintain consistent sizing,
    /// then adds a subtle shadow on top of that background.
    /// Without this, the shadow would be applied to the entire button view,
    /// leading to inconsistent visuals.
    ///
    /// Helps maintain a clean and consistent UI across all map overlay buttons.
    var mapControlButtonShadowViewModifier: some View {
        self
            .background {
                Color.clear
                    .mapOverlayButtonBackgroundViewModifier
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -1, y: 1)
            }
    }
    
    /// Limits the length of a bound `String` input to a specified number of characters.
    /// Observes changes to the binding and trims any excess characters
    /// beyond the given limit.
    ///
    /// - Parameters:
    ///   - binding: The `Binding<String>` to monitor and constrain.
    ///   - length: The maximum number of characters allowed.
    /// - Returns: A modified view that enforces the input length restriction.
    ///
    /// Example:
    /// ```swift
    /// @State private var text = ""
    ///
    /// TextField("Enter text", text: $text)
    ///     .limitInputLengthViewModifier($text, to: 10)
    /// ```
    func limitInputLengthViewModifier(_ binding: Binding<String>, to length: Int) -> some View {
        self
            .onChange(of: binding.wrappedValue) { _, newValue in
                if newValue.count > length {
                    binding.wrappedValue = String(newValue.prefix(length))
                }
            }
    }
    
    /// Positions a custom map control button at the bottom trailing corner,
    /// aligned with Apple’s default map controls.
    ///
    /// Ensures consistent alignment, spacing, and padding so custom buttons
    /// visually match the system-provided map controls on the trailing side.
    ///
    /// Use this modifier when placing custom controls alongside Apple map UI
    /// to maintain a clean and consistent layout.
    var mapBottomTrailingButtonsViewModifier: some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
            .padding(.bottom, 40)
            .mapBottomTrailingButtonsTrailingPadding
    }
    
    /// Applies a consistent corner radius to sheets on iOS 26 and above.
    /// Enhances the visual appearance of sheets across the app
    /// and maintains a unified design language.
    ///
    /// This modifier is considered essential for improving sheet presentation.
    /// On earlier iOS versions, it leaves the view unchanged.
    @ViewBuilder
    var sheetCornerRadiusViewModifier: some View {
        if #available(iOS 26, *) {
            self
                .presentationCornerRadius(40)
        } else {
            self
        }
    }
    
    /// Applies a background style to saved location pin buttons
    /// based on their placement in the map UI.
    ///
    /// Pins shown at the top of the map (e.g. under the search bar)
    /// use a different glass background to match their surrounding content.
    ///
    /// - Parameter type: Defines the visual style based on placement.
    /// - Returns: A modified view with the appropriate background applied.
    @ViewBuilder
    func savedLocationPinButtonBackgroundViewModifier(type: MapTypes) -> some View {
        switch type {
        case .primary:
            self.background(.regularMaterial)
            
        case .secondary:
            self.background(.clear)
        }
    }
    
    /// Applies a glass-style visual effect to saved location pin buttons,
    /// adapting to different iOS versions for visual consistency.
    ///
    /// On iOS 26 and above, a system glass effect is applied based on the map type
    /// and color scheme. On earlier versions, a capsule outline is used to
    /// approximate a similar appearance and match the overall shape.
    ///
    /// - Parameters:
    ///   - type: Defines the visual style based on map type.
    ///   - colorScheme: The current color scheme used to adjust the effect.
    /// - Returns: A modified view with the appropriate visual styling applied.
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
    
    /// Applies vertical content margins to marker item lists within scrollable views.
    ///
    /// Adds spacing at the top and bottom of the scroll content to improve layout,
    ///
    /// Ensures a more balanced and readable scrolling experience.
    var markerItemListViewModifier: some View {
        self
            .contentMargins(.top, 10, for: .scrollContent)
            .contentMargins(.bottom, 80, for: .scrollContent)
    }
}

// MARK: - EXTENSIONS
fileprivate extension View {
    /// Applies trailing padding for map bottom trailing buttons,
    /// adapting spacing based on the iOS version.
    ///
    /// On iOS 26 and above, default system padding is used to align
    /// with Apple’s map control spacing. On earlier versions,
    /// a reduced trailing padding is applied to better match the layout.
    ///
    /// Ensures consistent alignment with system map controls
    /// across different OS versions.
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

