import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeModule(
    name: "Presentation",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.Domain,
        .SPM.SnapKit
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
