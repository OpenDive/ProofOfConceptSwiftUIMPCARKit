import SwiftUI
import RealityKit
import ARKit
import FocusEntity

class FocusARView: ARView {
    enum FocusStyleChoices {
        case classic
        case material
        case color
    }

    var focusStyle: FocusStyleChoices = .classic
    var focusEntity: FocusEntity?

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)

        switch self.focusStyle {
        case .color:
            self.focusEntity = FocusEntity(on: self, focus: .plane)
        case .material:
            do {
                let onColor: MaterialColorParameter = try .texture(.load(named: "Add"))
                let offColor: MaterialColorParameter = try .texture(.load(named: "Open"))
                self.focusEntity = FocusEntity(
                    on: self,
                    style: .colored(
                        onColor: onColor,
                        offColor: offColor,
                        nonTrackingColor: offColor
                    )
                )
            } catch {
                self.focusEntity = FocusEntity(on: self, focus: .classic)
            }
        default:
            self.focusEntity = FocusEntity(on: self, focus: .classic)
        }

        self.setupARView()
    }

    func setupARView() {
        let config = ARWorldTrackingConfiguration()

        config.planeDetection = [.vertical]
        config.environmentTexturing = .automatic

        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }

        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        config.isCollaborationEnabled = true

        self.session.run(config)
    }

    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
