import ProjectDescription

public extension TargetDependency {
    enum Project {}
}

public extension TargetDependency.Project {
    static let Presentation = TargetDependency.project(
        target: "Presentation",
        path: .relativeToRoot("Projects/Presentation")
    )
    static let Domain = TargetDependency.project(
        target: "Domain",
        path: .relativeToRoot("Projects/Domain")
    )
    static let Data = TargetDependency.project(
        target: "Data",
        path: .relativeToRoot("Projects/Data")
    )
}
