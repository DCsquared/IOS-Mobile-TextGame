//
//  TownViewController.swift
//  TypicalRPG
//
//  Created by student on 8/29/01.
//  Copyright © 2001 cs@eku.edu. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class TownViewController: UIViewController{

    @IBOutlet weak var Vocation: UITextField!
    @IBOutlet weak var Level: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var townDescription: UITextView!
    var maxHp = 1
    var hp = 1
    var atk = 1
    var def = 1
    var mp = 1
    var exp = 0
    var lvl = 1
    var inn = 0
    var toNextLVL = 50
    var gold = 10
    var nme = "bob"
    var voc = "adventurer"
    var song = "adventuring_song.mp3"
    var town = "Cadence"
    var backgroundMusicPlayer = AVAudioPlayer()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let vr = ((parent as! TabBarViewController).viewControllers![0] as! RPGViewController).Name.textColor
        Name.textColor = vr
        Level.textColor = vr
        townDescription.textColor = vr
        Vocation.textColor = vr
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        player0.experience = Int64(self.exp)
        player0.defense = Int32(self.def)
        player0.attack = Int32(self.atk)
        player0.health = Int16(self.hp)
        player0.level = Int16(self.lvl)
        player0.magic = Int32(self.mp)
        player0.gold = Int64(self.gold)
        player0.vocation = self.voc
        player0.name = self.Name.text
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do
        {
            let playerResults = try managedObjectContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            
            //(playerResults[0] as! Player).name = ""
            //(playerResults[0] as! Player).vocation = ""
            maxHp = Int((playerResults[0] as! Player).mhealth)
            hp = Int((playerResults[0] as! Player).health)
            atk = Int((playerResults[0] as! Player).attack)
            def = Int((playerResults[0] as! Player).defense)
            mp = Int((playerResults[0] as! Player).magic)
            exp = Int((playerResults[0] as! Player).experience)
            lvl = Int((playerResults[0] as! Player).level)
            toNextLVL = Int((playerResults[0] as! Player).tnlevel)
            gold = Int((playerResults[0] as! Player).gold)
            //voc = (playerResults[0] as! Player).vocation!
            //nme = (playerResults[0] as! Player).name!
            
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    func saveData()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do
        {
            try managedObjectContext.save()
            
            // extra statement
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func slaying(_ sender: UIButton) {
        performSegue(withIdentifier: "slay", sender: nil)
    }
    
    @IBAction func inn(_ sender: UIButton) {
        inn = inn + 1
        let alertController = UIAlertController(title: "The Inn",
                                                message: "You are now well rested and at full health. ",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "OK",
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil)
        
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        hp = maxHp
    }
    
    @IBAction func store(_ sender: UIButton) {
        performSegue(withIdentifier: "buy", sender: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //sets picker to what user had before
        Name.text = nme
        Vocation.text = voc
        Level.text = String(lvl)
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        if inn == 20{
            player0.sleepy = 1
        }
        
        saveData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
