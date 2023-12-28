import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeModule(
    name: "Data",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.Domain,
        .SPM.Moya,
        .SPM.RXSwift,
        .SPM.RXMoya
    ]
)

