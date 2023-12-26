import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeModule(
    name: "Presentation",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.Domain,
        .SPM.SnapKit,
        .SPM.RXSwift
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
