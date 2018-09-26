//
//  AchievmentsViewController.swift
//  TypicalRPG
//
//  Created by student on 8/29/01.
//  Copyright © 2001 cs@eku.edu. All rights reserved.
//

import UIKit
import CoreData

class AchievmentsViewController: UIViewController {

    @IBOutlet weak var i: UILabel!
    @IBOutlet weak var can: UILabel!
    @IBOutlet weak var just: UILabel!
    @IBOutlet weak var cause: UILabel!
    @IBOutlet weak var sleepy: UILabel!
    @IBOutlet weak var redo: UILabel!
    @IBOutlet weak var sage: UILabel!
    @IBOutlet weak var boss: UILabel!
    @IBOutlet weak var trained: UILabel!
    @IBOutlet weak var slayer: UILabel!
    @IBOutlet weak var novice: UILabel!
    @IBOutlet weak var peasant: UILabel!
    @IBOutlet weak var begger: UILabel!
    @IBOutlet weak var rich: UILabel!
    @IBOutlet weak var dj: UILabel!
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star6: UIImageView!
    @IBOutlet weak var star7: UIImageView!
    @IBOutlet weak var star8: UIImageView!
    @IBOutlet weak var star9: UIImageView!
    @IBOutlet weak var star10: UIImageView!
    @IBOutlet weak var star11: UIImageView!
    @IBOutlet weak var star12: UIImageView!
    @IBOutlet weak var star13: UIImageView!
    @IBOutlet weak var star14: UIImageView!
    @IBOutlet weak var star15: UIImageView!
    @IBOutlet weak var star16: UIImageView!
    
    var stars = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        star1.isHidden = true;
        star2.isHidden = true;
        star3.isHidden = true;
        star4.isHidden = true;
        star5.isHidden = true;
        star6.isHidden = true;
        star7.isHidden = true;
        star8.isHidden = true;
        star9.isHidden = true;
        star10.isHidden = true;
        star11.isHidden = true;
        star12.isHidden = true;
        star13.isHidden = true;
        star14.isHidden = true;
        star15.isHidden = true;
        star16.isHidden = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //sets picker to what user had before
        let vr = ((parent as! TabBarViewController).viewControllers![0] as! RPGViewController)
        player.textColor = vr.Name.textColor
        begger.textColor = vr.Name.textColor
        boss.textColor = vr.Name.textColor
        can.textColor = vr.Name.textColor
        cause.textColor = vr.Name.textColor
        dj.textColor = vr.Name.textColor
        i.textColor = vr.Name.textColor
        just.textColor = vr.Name.textColor
        novice.textColor = vr.Name.textColor
        peasant.textColor = vr.Name.textColor
        redo.textColor = vr.Name.textColor
        rich.textColor = vr.Name.textColor
        sage.textColor = vr.Name.textColor
        slayer.textColor = vr.Name.textColor
        sleepy.textColor = vr.Name.textColor
        trained.textColor = vr.Name.textColor
        
        loadData()
        
    }

    func loadData()
    {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        do
        {
            let playerResults = try managedObjectContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            
            if Int((playerResults[0] as! Player).pl) == 1
            {
                star1.isHidden = false
            }
            if Int((playerResults[0] as! Player).dj) == 1
            {
                star2.isHidden = false
            }
            if Int((playerResults[0] as! Player).beggar) == 1
            {
                star3.isHidden = false
            }
            if Int((playerResults[0] as! Player).rich) == 1
            {
                star4.isHidden = false
            }
            if Int((playerResults[0] as! Player).peasant) == 1
            {
                star5.isHidden = false
            }
            if Int((playerResults[0] as! Player).novice) == 1
            {
                star6.isHidden = false
            }
            if Int((playerResults[0] as! Player).trained) == 1
            {
                star7.isHidden = false
            }
            if Int((playerResults[0] as! Player).slayer) == 1
            {
                star8.isHidden = false
            }
            if Int((playerResults[0] as! Player).boss) == 1
            {
                star9.isHidden = false
            }
            if Int((playerResults[0] as! Player).sage) == 1
            {
                star10.isHidden = false
            }
            if Int((playerResults[0] as! Player).sleepy) == 1
            {
                star11.isHidden = false
            }
            if Int((playerResults[0] as! Player).redo) == 1
            {
                star12.isHidden = false
            }
            if Int((playerResults[0] as! Player).just) == 1
            {
                star13.isHidden = false
            }
            if Int((playerResults[0] as! Player).cause) == 1
            {
                star14.isHidden = false
            }
            if Int((playerResults[0] as! Player).i) == 1
            {
                star15.isHidden = false
            }
            if Int((playerResults[0] as! Player).can) == 1
            {
                star16.isHidden = false
            }
        }
        catch let error
        {
            print(error.localizedDescription)
        }
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
