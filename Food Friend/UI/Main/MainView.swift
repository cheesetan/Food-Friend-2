//
//  MainView.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI

struct MainView: View {
    
    enum Tabs: String, CaseIterable {
        case foods = "Foods"
        case social = "Social"
        case settings = "Settings"
    }
    
    @AppStorage("tabSelection", store: .standard) var tabSelection = Tabs.foods.rawValue
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(Tabs.allCases, id: \.rawValue) { tab in
                TabItem(tab: tab)
            }
        }
    }
    
    func TabItem(tab: Tabs) -> some View {
        ViewForTabItem(tab: tab)
            .tag(tab.rawValue)
            .tabItem {
                Label(tab.rawValue, systemImage: ImageForTabItem(tab: tab))
            }
    }
    
    func ViewForTabItem(tab: Tabs) -> AnyView {
        switch tab {
            case .foods: return AnyView(FoodsView())
            case .social: return AnyView(SocialView())
            case .settings: return AnyView(SettingsView())
        }
    }
    
    func ImageForTabItem(tab: Tabs) -> String {
        switch tab {
            case .foods: return "checklist"
            case .social: return "person.2"
            case .settings: return "gearshape"
        }
    }
}

#Preview {
    MainView()
}
