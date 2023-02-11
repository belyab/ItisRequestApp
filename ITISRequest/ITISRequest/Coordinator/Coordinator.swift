import UIKit

public protocol Coordinator : class {

    var childCoordinators: [Coordinator] { get set }

    init(navigationController:UINavigationController)

    func start()
}
