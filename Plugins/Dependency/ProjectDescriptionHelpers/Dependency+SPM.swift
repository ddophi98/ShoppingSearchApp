import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let RXSwift = TargetDependency.external(name: "RxSwift")
    static let RXMoya = TargetDependency.external(name: "RxMoya")
    static let RXCocoa = TargetDependency.external(name: "RxCocoa")
}
