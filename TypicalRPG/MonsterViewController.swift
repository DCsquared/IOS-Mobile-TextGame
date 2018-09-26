//
//  MonsterViewController.swift
//  TypicalRPG
//
//  Created by student on 8/29/01.
//  Copyright © 2001 cs@eku.edu. All rights reserved.
//

import UIKit
import CoreData

class MonsterViewController: UIViewController {

    @IBAction func flee(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    var maxHp = 16
    var hp = 16
    var atk = 8
    var def = 15
    var mp = 40
    var exp = 0
    var toNextLVL = 50
    var gold = 10
    var voc = "adventurer"
    var nme = "bob"
    @IBOutlet weak var battleText: UITextView!
    @IBOutlet weak var normalAttack: UIButton!
    @IBOutlet weak var magicAttack: UIButton!
    @IBOutlet weak var health: UIButton!
    @IBOutlet weak var mana: UIButton!
    
	
	var encounters = 0
	var monster = ""
    var charlvl = 0
    let monsters = [["Goblin", "Owlbear", "Slime", "Orc"],
                    ["Harpie", "Troll", "Wolf", "Eagle"],
                    ["Bandit", "Giant", "Werewolf"],
                    ["Skeleton", "Husk", "Vampire"],
                    ["Banshee","Minotaur","Roc","Bandit Leader","Death Knight","Vampire Lord"]
                   ]
    var vocs = ["Fighter","Thief","Hunter","Wizard"]
    var b = 0
    let bonus = [10, 10, 10, 15]
	let cost = [6, 6, 6, 3]
    let rps = [0, 1, 2]
    var playerAttack = 4
    var monsterAttack = 4
    var monsterHealth = 8
    var expg = 25
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        encounter()
        battleText.textColor = ((parent as! TabBarViewController).viewControllers![0] as! RPGViewController).Name.textColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do
        {
            let playerResults = try managedObjectContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            
            maxHp = Int((playerResults[0] as! Player).mhealth)
            hp = Int((playerResults[0] as! Player).health)
            atk = Int((playerResults[0] as! Player).attack)
            def = Int((playerResults[0] as! Player).defense)
            mp = Int((playerResults[0] as! Player).magic)
            exp = Int((playerResults[0] as! Player).experience)
            charlvl = Int((playerResults[0] as! Player).level)
            toNextLVL = Int((playerResults[0] as! Player).tnlevel)
            gold = Int((playerResults[0] as! Player).gold)
            voc = (playerResults[0] as! Player).vocation!
            nme = (playerResults[0] as! Player).name!
            b = vocs.index(of: "Thief")!
            
        }
        catch let error
        {
            print(error.localizedDescription)
        }
        let bit = Int(hp)
        encounters = charlvl / 5
        monsterHealth = bit + Int(arc4random_uniform(5))
    }
    
    func saveData()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        player0.experience = Int64(self.exp)
        player0.defense = Int32(self.def)
        player0.attack = Int32(self.atk)
        player0.health = Int16(self.hp)
        player0.level = Int16(self.charlvl)
        player0.magic = Int32(self.mp)
        player0.gold = Int64(self.gold)
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
    
    func death(){
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        player0.saved = 0
        player0.redo = 1
        tabBarController?.selectedIndex = 0
    }
    
    func levelUP() {
        charlvl += 1
        gold += 30
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        if(charlvl == 2){
            player0.novice = 1
        }else if charlvl == 5{
            player0.trained = 1
        }else if charlvl == 20{
            player0.slayer = 1
        }else if charlvl == 50{
            player0.sage = 1
        }else if charlvl == 100{
            player0.boss = 1
        }
        if gold == 999999{
            player0.rich = 1
        }
        let alertController = UIAlertController(title: "Congradulations!",
            message: " You have leveled up! \(charlvl)",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "Cool beans!",
                                      style: UIAlertActionStyle.default,
                                      handler: nil)
        alertController.addAction(ok)
        
        present(alertController, animated: true, completion: nil)
        saveData()
    }
    func Continue(){
        let alertController = UIAlertController(title: "Victory, you have slain the \(monster)! You have gained 25 experience. Would you like to continue on or go back to town?",
            message: "Would you like to grind some more?",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let nowAction = UIAlertAction(title: "Yes, 'cause I'm a boss!",
                                      style: UIAlertActionStyle.default,
                                      handler: {(alertAction: UIAlertAction!)
                                        in
                                        self.encounter()
        })
        
        let cancelAction = UIAlertAction(title: "No, I'm tired.",
                                         style: UIAlertActionStyle.cancel,
                                         handler: {(alertAction: UIAlertAction!)
                                            in
                                            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(nowAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonIsClicked(_ sender: UIButton) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedObjectContext)
        let player0 = Player(entity: entityPlayer!, insertInto: managedObjectContext)
        
        let bit = arc4random_uniform(3)
        if sender === normalAttack
        {
            let playerChance = rps[Int(bit)]
            let monsterChance = rps[Int(bit)]
                
                switch playerChance {
                case 0:
                if monsterChance == 1
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterChance == 2
                {
                    monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth <= 0
					{
						exp += expg
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
                        exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
				}
				case 1:
				if monsterChance == 2
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if (parent as! RPGViewController).hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterChance == 0
                {
                    monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth <= 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
				}
				default:
				if monsterChance == 0
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterChance == 1
                {
                    monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth == 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					monsterHealth = monsterHealth - (monsterHealth / 4)
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).You dealt \(monsterHealth / 4) taking the \(monster)'s health down to \(monsterHealth).)"
					if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
				}
            }
        
		if sender == magicAttack
        {
            //playerAttack = rps[Int(arc4random(3)]
            //monsterAttack = rps[Int(arc4random(3)]
                
                switch playerAttack {
                case 1:
                if monsterAttack == 2
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterAttack == 3
                {
					mp = mp - cost[b]
                    monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth <= 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					mp = mp - cost[b]
					monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp). You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					if (parent as! RPGViewController).hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
						exp += exp
						if exp % exp == 0
						{
							levelUP()
						}
                        Continue()
					}
				}
				case 2: 
				if monsterAttack == 3
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterAttack == 1
                {
					mp = mp - cost[b]
                    monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth <= 0
					{
						exp += exp
						if exp % exp == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					mp = mp - cost[b]
					monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp). You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
						exp += exp
						if exp % exp == 0
						{
							levelUP()
						}
                        Continue()
					}
				}
				default:
				if monsterAttack == 1
                {
                    hp = hp - (hp / 4)
                    battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp).)"
                    if hp == 0
                    {
                        battleText.text = "Game OVer! \(monster) has killed you!"
                        death()
                    }
                }
                else if monsterAttack == 2
                {
					mp = mp - cost[b]
                    monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					if monsterHealth <= 0
					{
						exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
                }
				else
				{
					hp = hp - (hp / 4)
					mp = mp - cost[b]
					monsterHealth = monsterHealth - (monsterHealth / 4 + bonus[b])
					battleText.text = "You got hit for \(hp / 4) taking your health down to \(hp). You dealt \(monsterHealth / 4 + bonus[b]) taking the \(monster)'s health down to \(monsterHealth).)"
					
					if hp == 0
                    {
                        battleText.text = "Game Over! \(monster) has killed you!"
                        death()
                    }
					else if monsterHealth <= 0
					{
                        exp += exp
						if (exp % exp) == 0
						{
							levelUP()
						}
                        Continue()
					}
				
                }
        
		if sender == health
		{
			hp += (presentingViewController as! StoreViewController).healing[charlvl / 5]
			battleText.text = "You healed \((presentingViewController as! StoreViewController).healing[charlvl / 5]). Youre current health is \(hp)"
		}
		if sender == mana
		{
			mp += (presentingViewController as! StoreViewController).mana[charlvl / 5]
			battleText.text = "You healed \((presentingViewController as! StoreViewController).mana[charlvl / 5]). Youre current mana is \(mp)"
		}
    }
            }
        }
        player0.experience = Int64(self.exp)
    }
    
    func encounter()
    {
		if charlvl % 5 == 0
		{
			monster = monsters[4][Int(encounters - 1)]
			battleText.text = "You have encountered a \(monster). What would you like to do?"   
		}
        else if encounters <= 2
        {
			monster = monsters[0][Int(arc4random_uniform(4))]
            battleText.text = "You have encountered a \(monster). What would you like to do?"   
        }
		else if encounters == 3
		{
			monster = monsters[1][Int(arc4random_uniform(4))]
			battleText.text = "You have encountered a \(monster). What would you like to do?"   
		}
		else if encounters == 4
		{
			monster = monsters[2][Int(arc4random_uniform(4))]
			battleText.text = "You have encountered a \(monster). What would you like to do?"   
		}
		else 
		{
			monster = monsters[3][Int(arc4random_uniform(4))]
			battleText.text = "You have encountered a \(monster). What would you like to do?"   
		}
		//buttonIsClicked(sender)
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
