import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "com.shoppingSearch",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: .iphone),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Path? = nil,
        makeExample: Bool = false
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug, xcconfig: .relativeToRoot("Config.xcconfig")),
                .release(name: .release, xcconfig: .relativeToRoot("Config.xcconfig"))
            ], defaultSettings: .recommended)

        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            entitlements: entitlements,
            dependencies: [.target(name: name)]
        )
    
        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name), .makeScheme(target: .release, name: name)]

        let targets: [Target] = [appTarget, testTarget]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        let schemeName: String
        if target == .debug {
            schemeName = "\(name)-debug"
        } else if target == .release {
            schemeName = "\(name)-release"
        } else {
            schemeName = name
        }
        
        return Scheme(
            name: schemeName,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
