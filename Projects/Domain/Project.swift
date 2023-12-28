import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeModule(
    name: "Domain",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .SPM.RXSwift
    ]
)
