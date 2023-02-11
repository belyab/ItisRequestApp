import UIKit

class SignUpCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signUpController = SignUpViewController()
        signUpController.delegate = self
        self.navigationController.viewControllers = [signUpController]
    }
}

extension SignUpCoordinator: SignUpViewControllerDelegate {

    func navigateToStudentProfile() {
       let studentProfileCoordinator = StudentProfilleCoordinator(navigationController: navigationController)
//        studentProfileCoordinator.delegate = self
       childCoordinators.append(studentProfileCoordinator)
        studentProfileCoordinator.start()
    }
}

