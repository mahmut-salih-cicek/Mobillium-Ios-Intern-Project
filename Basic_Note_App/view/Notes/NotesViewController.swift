//
//  NotesViewController.swift
//  Basic_Note_App
//
//  Created by xmod on 1.08.2022.
//

import UIKit

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 

    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteLabel: UILabel!
    @IBOutlet weak var searchBarFrame: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var divider: UILabel!
    

    var testNoteData = [TestNoteModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Table View
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        // Fake Model Init
        let notes1 = TestNoteModel(noteTitleText: "Lemon Cake & Blueberry", noteContentText: "Sunshine-sweet lemon blueberry layer cake dotted with juicy berries and topped with lush cream cheese…")
        let notes2 = TestNoteModel(noteTitleText: "Black Sands", noteContentText: "Black Sands is the fourth studio album by English DJ Bonobo. It was released on 29 March 2010. The cover…")
        let notes3 = TestNoteModel(noteTitleText: "Fall Marketing Campaign", noteContentText: "Having other strong marketing campaigns centered around fall can set you apart from competitors. It...")
        let notes4 = TestNoteModel(noteTitleText: "Color Science", noteContentText: "Just as dialog, acting, and music are tools filmmakers use to convey meaning and emotion, color can be…")
        testNoteData.append(notes1)
        testNoteData.append(notes2)
        testNoteData.append(notes3)
        testNoteData.append(notes4)
        
        
        
        // searchBarFrame property
        searchBarFrame.backgroundColor = .white
        searchBarFrame.layer.cornerRadius = 4
        searchBarFrame.layer.borderWidth = 1
        searchBarFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        //divider property
        divider.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        
    
        // User Default kayıt eedilen access token alındı
        print("token is here!!"+UserAccessToken.value(defaultValue: "token is nil", forKey: "AccessToken"))
        
        
        //addNote label action
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddnotesSegue))
        addNoteLabel.isUserInteractionEnabled = true
        addNoteLabel.addGestureRecognizer(tap)
    
    }
    
    
    @objc func AddnotesSegue(){
        performSegue(withIdentifier: "AddNoteSegue", sender: nil)
    }
    
    
    // kaç adet cell olucak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testNoteData.count
    }
    
    
    // cell de gösterilecekler
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotesTableViewCell
        cell.noteTitle.text = testNoteData[indexPath.row].noteTitleText
        cell.noteContent.text = testNoteData[indexPath.row].noteContentText
        return cell
    }
    
        
    

}

// Sadece test amaclıdır model klosurunde gercek struct hazırlandı
struct TestNoteModel{
    let noteTitleText : String
    let noteContentText : String
}
    

   

