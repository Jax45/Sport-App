

import UIKit

protocol filterPlayersDelegate {
    func filterTeams(filter: String)
}

class FilterPlayersViewController: UIViewController {

    var delegate: filterPlayersDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        let filter = sender.titleLabel!.text!
        delegate.filterTeams(filter: filter)
        dismiss(animated: true, completion: nil)
    }
    

}
