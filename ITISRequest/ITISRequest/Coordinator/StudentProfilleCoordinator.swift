import UIKit

class StudentProfilleCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let studentProfileController = StudentProfileViewController()
        studentProfileController.delegate = self
        self.navigationController.pushViewController(studentProfileController, animated: true)
    }
}

extension StudentProfilleCoordinator : StudentProfileViewControllerDelegate {
    
////    // Navigate to third page
////    func navigateToThirdPage() {
////        let thirdViewController : ThirdViewController = ThirdViewController()
////        thirdViewController.delegate = self
////        self.navigationController.pushViewController(thirdViewController, animated: true)
////    }
////    
////    // Navigate to first page
////    func navigateToFirstPage() {
////        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
////    }
}
