#if os(iOS)
import Foundation
import UIKit
/**
 * - Fixme: ⚠️️ Add for macOS as well? or is it supported as is?
 */
public class Emailer {
   public typealias MailInitiator = UIViewController & MFMailComposeViewControllerDelegate
   /**
    * - Fixme: ⚠️️ Add example
    * - Parameters:
    *   - viewController: the mail vc
    *   - text: text to mail
    *   - recipient: "address@example.com"
    */
   public static func sendMail(on viewController: MailInitiator, text: String, recipient: String) -> UIAlertAction {
      UIAlertAction(title: "Send Email", style: .default) {
         (_: UIAlertAction) in
         DispatchQueue.main.async {
            if MFMailComposeViewController.canSendMail() {
               let composeVC = MFMailComposeViewController()
               composeVC.mailComposeDelegate = viewController
               composeVC.setToRecipients([recipient])
               composeVC.setSubject("Console Log")
               composeVC.setMessageBody(text, isHTML: false)
               viewController.present(composeVC, animated: true, completion: nil)
            } else {
               let alert = UIAlertController(title: "Email account required",
                                             message: "Please configure an email account in Mail",
                                             preferredStyle: .alert)
               alert.addAction(UIAlertAction.ok())
               viewController.present(alert, animated: true, completion: nil)
            }
         }
      }
   }
}
#endif
