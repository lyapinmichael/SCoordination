//
//  BaseCoordinator.swift
//  BNCoordination
//
//  Created by Ляпин Михаил on 30.04.2024.
//

import UIKit

open class BaseCoordinator: Coordinating, DetachedTransitionHandling {
    // MARK: Public properties 
    
    public weak var parentCoordinator: Coordinating?
    
    public private(set) var sharedDependencyContainer: ModuleDependencyContainer?
    
    public private(set) var dependencyContainer = ModuleDependencyContainer()
    
    public private(set) var referenceCounter = ReferenceCounter()
    
    open var detachedReason: Reason.Type?
    
    // MARK: Internal properties
    
    var childCoordinators: [Coordinating] = []
    
    // MARK: Init
    
    public init(sharedDependencyContainer: ModuleDependencyContainer? = nil, with preconditionData: [String: Any] = [:]) {
        self.sharedDependencyContainer = sharedDependencyContainer
        preconditionData.isEmpty ? prepareToStart() : prepareToStart(with: preconditionData)
        referenceCounter.listener = self
    }
    
    // MARK: Public methods
    
    // --- Overridable ---
    
    /// Override this method to implement custom starting behavior for specific coordinator.
    open func start() {
        return
    }
    
    /// Is called when **some** precondition data was passed to initializer of this
    /// coordinator.
    ///
    /// Override this method to implement custom behavior that is triggered right
    /// when this coordinator id being initialized.
    ///
    /// - Parameter preconditionData:
    ///     Receives some dictionary with data, passed a initialization time of
    ///     this coordinator.
    open func prepareToStart(with preconditionData: [String: Any]) {
        return
    }
    
    /// Is called when **no** precondition data was passed to initializer of this
    /// coordinator.
    ///
    /// Override this method to implement custom behavior that is triggered right
    /// when this coordinator id being initialized.
    open func prepareToStart() {
        return
    }
    
    // --- Final ---
    
    public final func addChild(_ childCoordinator: some Coordinating, shouldStartImmediately: Bool = true) {
        (childCoordinator as? BaseCoordinator)?.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        if shouldStartImmediately { childCoordinator.start() }
        didAddChild()
    }
    
    func didAddChild() {
        return
    }
    
    public final func removeChild(_ childCoordinator: some Coordinating) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === childCoordinator {
                childCoordinators.remove(at: index)
                didRemoveChild()
                break
            }
        }
    }
    
    func didRemoveChild() {
        return
    }
    
    public func stop() {
        dependencyContainer.clearDependencies()
        parentCoordinator?.removeChild(self)
        childCoordinators = []
    }
}

extension BaseCoordinator: ReferenceCounterListening {
    public func onCountDidReachZero() {
        parentCoordinator?.removeChild(self)
    }    
}
