import SwiftUI
import RealityKit
import ARKit
import MultipeerConnectivity

struct MainARView: View {
    @StateObject private var arViewModel: MainARViewModel = MainARViewModel()
    @StateObject private var multipeerSession: MultipeerSession = MultipeerSession()

    @State private var isPlacementEnabled = false
    @State private var errorMessage: String = ""
    @State private var isShowingPopup: Bool = false
    @State private var arViewContainer = ARViewContainer()

    var body: some View {
        ZStack {
            arViewContainer
                .environmentObject(self.arViewModel)
                .environmentObject(self.multipeerSession)
                .ignoresSafeArea()
                .onTapGesture { location in
                    arViewModel.location = location
                }
        }
    }
}

#Preview {
    MainARView()
}
