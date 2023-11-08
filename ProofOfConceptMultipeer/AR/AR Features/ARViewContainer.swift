import RealityKit
import ARKit
import SwiftUI
import MultipeerConnectivity
import Combine
import SceneKit

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var arViewModel: MainARViewModel
    @EnvironmentObject var multipeerSession: MultipeerSession

    func makeUIView(context: Context) -> ARView {
        let arView = FocusARView(frame: .zero)
        arView.addCoaching()
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        #if !targetEnvironment(simulator)
        if let modelEntity = self.arViewModel.modelConfirmedForPlacement {
            let anchorEntity = AnchorEntity(plane: .any)
            let clonedEntity = modelEntity.clone(recursive: true)
            clonedEntity.generateCollisionShapes(recursive: true)
            uiView.installGestures([.all], for: clonedEntity)
            anchorEntity.addChild(clonedEntity)
            uiView.scene.addAnchor(anchorEntity)

            DispatchQueue.main.async {
                self.arViewModel.modelConfirmedForPlacement = nil
            }
        }
        
        if let receivedData = multipeerSession.receivedData, let peerID = multipeerSession.dataSenderPeerID {
            do {
                if let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: receivedData) {
                    // Run the session with the received world map.
                    let configuration = ARWorldTrackingConfiguration()
                    configuration.planeDetection = .horizontal
                    configuration.initialWorldMap = worldMap
                    uiView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
                    
                    DispatchQueue.main.async {
                        self.multipeerSession.mapProvider = peerID
                    }
                } else if let anchor = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARAnchor.self, from: receivedData) {
                    print("RECEIVER: \(anchor)")
                    uiView.session.add(anchor: anchor)
                } else {
                    print("unknown data recieved from \(peerID)")
                }
            } catch {
                print("can't decode data recieved from \(peerID): error - \(error)")
            }

            DispatchQueue.main.async {
                self.multipeerSession.receivedData = nil
                self.multipeerSession.dataSenderPeerID = nil
            }
        }
        
        if let location = self.arViewModel.location {
            print("SENDER: \(location)")
            guard let hitTestResult = uiView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal).first else {
                return
            }

            let anchor = ARAnchor(name: "testScene", transform: hitTestResult.worldTransform)

            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true) else {
                fatalError("can't encode anchor")
            }
            self.multipeerSession.sendToAllPeers(data)
            
            DispatchQueue.main.async {
                self.arViewModel.location = nil
            }
        }
        #endif
    }
    
    private func loadRedPandaModel() -> SCNNode {
        let sceneURL = Bundle.main.url(forResource: "max", withExtension: "scn", subdirectory: "Assets.scnassets")!
        let referenceNode = SCNReferenceNode(url: sceneURL)!
        referenceNode.load()
        
        return referenceNode
    }
}
