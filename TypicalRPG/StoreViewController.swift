//
//  StoreViewController.swift
//  TypicalRPG
//
//  Created by student on 8/29/01.
//  Copyright © 2001 cs@eku.edu. All rights reserved.
//

import UIKit
import CoreData

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //let charLvl = (parent as! RPGViewController).lvl
    @IBAction func leave(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    let healing = [5, 15, 20, 25, 30, 40]
    let mana = [5, 15, 20, 25, 30, 40]
    let weapons = [4, 7, 9, 10, 12, 14]
    let armor = [3, 4, 5, 7, 8, 10]
    let potionPrice = 4
    let base = [0, 1, 2, 3]
    var fighterItems = ["Health Potion", "Mana Potion", " Iron Longsword", "Ring Mail"]
    var theifItems = ["Health Potion", "Mana Potion", "Iron Daggers", "Padded Armor"]
    var hunterItems = ["Health Potion", "Mana Potion", "Elm Crossbow", "Hide Armor"]
    var wizardItems = ["Health Potion", "Mana Potion", "Iron Staff", "Cloth Robes"]
    
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
    
    func updateStore()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        let charLvl = player0.level
        //var armorDefense = player0.defense + (Int16)armor[charLvl % 5]
        //var weaponAttack = player0.attack + weapons[charLvl % 5]
        
        if charLvl <= 10 && charLvl > 5
        {
            fighterItems = ["Health Potion", "Mana Potion", "Steel Longsword", "Chain Mail"]
            theifItems = ["Health Potion", "Mana Potion", "Veridium Daggers", "Leather Armor"]
            hunterItems = ["Health Potion", "Mana Potion", "Yew Crossbow", "Scale Mail"]
            wizardItems = ["Health Potion", "Mana Potion", "Steel Staff", "Padded Robes"]

        }
        else if charLvl <= 15 && charLvl > 10
        {
            fighterItems = ["Health Potion", "Mana Potion", "Red Steel Battleaxe", "Splint Armor"]
            theifItems = ["Health Potion", "Mana Potion", " Red Steel Shortsword", "Leather Armor"]
            hunterItems = ["Health Potion", "Mana Potion", "Ironbark Crossbow", "Scale Mail"]
            wizardItems = ["Health Potion", "Mana Potion", "Red Steel Staff", "Elemental Robes"]
            
        }
        else if charLvl <= 25 && charLvl > 20
        {
            fighterItems = ["Health Potion", "Mana Potion", "Dragonbone Greatsword", "Steel Armor"]
            theifItems = ["Health Potion", "Mana Potion", "Silverite Scimitar", "Studded Leather Armor"]
            hunterItems = ["Health Potion", "Mana Potion", "Silverbark Crossbow", "Breastplate"]
            wizardItems = ["Health Potion", "Mana Potion", "Silverite Staff", "War Robes"]
            
        }
        else if charLvl <= 30 && charLvl > 25
        {
            fighterItems = ["Health Potion", "Mana Potion", "White Steel Greataxe", "Plate Armor"]
            theifItems = ["Health Potion", "Mana Potion", "Aurum Scimitar", "Studded Leather Armor"]
            hunterItems = ["Health Potion", "Mana Potion", "Dragonthorn Crossbow", "Half Plate Armor"]
            wizardItems = ["Health Potion", "Mana Potion", "Dragonbone Staff", "Astral Robes"]
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //sets picker to what user had before
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fighterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vc = ((parent as! TabBarViewController).viewControllers![2] as! SettingsViewController)
        
        if (parent as! RPGViewController).classSelection.selectedSegmentIndex == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
            
            updateStore()
            cell!.textLabel!.text = fighterItems[indexPath.row]
            cell!.textLabel!.textColor = vc.display.textColor
            
            return cell!
        }
        else if (parent as! RPGViewController).classSelection.selectedSegmentIndex == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
            
            updateStore()
            cell!.textLabel!.text = theifItems[indexPath.row]
            cell!.textLabel!.textColor = vc.display.textColor
            
            return cell!
        }
        else if (parent as! RPGViewController).classSelection.selectedSegmentIndex == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
            
            updateStore()
            cell!.textLabel!.text = hunterItems[indexPath.row]
            cell!.textLabel!.textColor = vc.display.textColor
            
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
            
            updateStore()
            cell!.textLabel!.text = wizardItems[indexPath.row]
            cell!.textLabel!.textColor = vc.display.textColor
            
            return cell!
        }
        
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
            let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
            
            let alert = UIAlertController(title: "Merchant", message: "How many would you like to buy?", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) -> Void in
                let textField = alert.textFields![0]
                print(textField.text!)
            })
            
            alert.addTextField{ (textField: UITextField) in
                textField.keyboardAppearance = .default
                textField.keyboardType = .decimalPad
                textField.clearButtonMode = .whileEditing
                
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
            
            if base[indexPath.row] < 2
            {
                player0.gold -= potionPrice
            }
            else if base[indexPath.row] == 2
            {
                player0.gold -= 40
            }
            else if base[indexPath.row] == 3
            {
                player0.gold -= 40
            }
            if player0.gold <= 1{
                player0.beggar = 1
            }
            saveData()
        
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
