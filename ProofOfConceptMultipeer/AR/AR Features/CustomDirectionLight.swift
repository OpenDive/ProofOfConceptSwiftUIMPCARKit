import RealityKit

class CustomDirectionalLight: Entity, HasDirectionalLight {
    required init() {
        super.init()
        self.light = DirectionalLightComponent(
            color: .white,
            intensity: 20000,
            isRealWorldProxy: true)
        self.shadow = DirectionalLightComponent.Shadow(
            maximumDistance: 10,
            depthBias: 5.0)
        self.orientation = simd_quatf(
            angle: -.pi / 1.5,
            axis: [0, 1, 0])
    }
}
