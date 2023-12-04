import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeModule(
    name: "App",
    product: .app,
    dependencies: [
        .Project.Presentation,
        .Project.Domain,
        .Project.Data,
        .SPM.Swinject
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
