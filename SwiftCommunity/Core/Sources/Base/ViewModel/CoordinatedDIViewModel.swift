//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcActivityIndicator
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

/// Protocol adding coordinators into ViewModels.
public protocol CoordinatedViewModelProtocol where Self: ViewModel {
    associatedtype RouteType: Route
    var router: UnownedRouter<RouteType> { get }
}

/// Protocol defining dependencies for a ViewModel.
public protocol DependencyInjectedViewModelProtocol where Self: ViewModel {
    associatedtype DependencyType
    var dependency: DependencyType { get }
}

/// Base class can be used to create ViewModels with Coordinator.
public class CoordinatedViewModel<R: Route>: ViewModel, CoordinatedViewModelProtocol, ActivityState {

    // MARK: Properties

    // Public

    public var router: UnownedRouter<R>

    public var activity = Activity()

    // MARK: Initialization

    public init(router: UnownedRouter<R>) {
        self.router = router
        super.init()
    }
}

/// Based class can be used to create dependency-injected ViewModels.
open class DIViewModel<D>: ViewModel, DependencyInjectedViewModelProtocol, ActivityState {

    // MARK: Properties

    // Public

    public var dependency: D

    public var activity = Activity()

    // MARK: Initialization

    public init(dependency: D) {
        self.dependency = dependency
        super.init()
    }
}

/// Based class can be used to create ViewModels containing dependencies and coordinator.
open class CoordinatedDIViewModel<R: Route, D>: DIViewModel<D>, CoordinatedViewModelProtocol {

    // MARK: Properties

    // Public

    public var router: UnownedRouter<R>

    // MARK: Initialization

    public init(router: UnownedRouter<R>, dependency: D) {
        self.router = router
        super.init(dependency: dependency)
    }
}
