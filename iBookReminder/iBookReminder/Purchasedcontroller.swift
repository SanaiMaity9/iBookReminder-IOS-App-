//
//  Purchasedcontroller.swift
//  iBookReminder
//
//  Created by Manish on 03/11/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import CoreData

class Purchasedcontroller: UITableViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    @IBOutlet var Barbtn: UIBarButtonItem!
    var people = [NSManagedObject]()
    var label: UILabel!
    var  emcell:UITableViewCell!
    var lbvw:UIView!
    @IBOutlet var catt: UITableView!
    var ig:String!
    var sln = [Int]()
    var uniqsln = [Int]()
    var bkmn = [String]()
    var autnme = [String]()
    var ii:String!
    var Images = [String: UIImage]()
    var Images1 = [String]()
    var databasePath = NSString()
    @IBOutlet var emvw: UIView!
    var Barbtn_Click = 0;
    struct defaultsKeys {
        static let bkid = "bki"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tabBarController?.tabBar.hidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        //
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        for var i=0; i<objects!.count; i++
        {
            
            if  var results = objects {
            
            
            if results.count > 0 {
            var match = results[i] as! NSManagedObject
            var purchase = match.valueForKey("purchase") as! NSNumber!
            
                if purchase == Optional(1){
            
                if contains(sln, i){
                    
                }else{
                
                    sln.append(i)
                }
                
                
                }else{
                    if let index = find(sln, i) {
                        sln.removeAtIndex(index)
                    }
              
                }
                
                }
            
            }else{
               
                println("error")
            }
        }
        
        
        //
        label = UILabel(frame: CGRectMake(0, 0, 300, 100))
        
        if sln.count > 0 {
            label.hidden = true
            // var label = UILabel(frame: CGRectMake(0, 0, 300, 100))
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 999 {
                    subview.removeFromSuperview()
                   
                    self.Barbtn.tintColor = UIColor.whiteColor()
                    self.Barbtn.enabled = true

                    
                }
            }
        }
        else {
            //
           self.Barbtn.tintColor = UIColor.clearColor()
            self.Barbtn.enabled = false
            //
            
            label.center = CGPointMake(150, 170)
            label.textColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            
            //label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.font = UIFont (name: "HelveticaNeue-Thin", size: 19)
            label.numberOfLines = 3
            label.tag = 999
            label.textAlignment = NSTextAlignment.Center
            label.text = " No list found. Click (+) in catelogue section to add new book details."
            self.view.addSubview(label)
        }
        //
       
        
        //
      
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        

        sln.removeAll(keepCapacity: true)
        
        viewDidLoad()
        tableView.reloadData()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FristviewCell
        //
       
        //
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
       
        if  var results = objects {
            
            println(sln[indexPath.row])
           
            var match = results[sln[indexPath.row]] as! NSManagedObject
          
            var purchase = match.valueForKey("purchase") as! NSNumber!

            if purchase == Optional(1){
            cell.bknmm.text = match.valueForKey("title") as! String!
            
            
            cell.authornm.text =  match.valueForKey("author") as! String!
            var k = match.valueForKey("bookimg") as! NSData!
            cell.bki.image = UIImage(data: k)
                
            }
        
        
            }else {
               println("NO data")
            }
            
     
        
        
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sln.count
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row)
        {
            
        case 0...indexPath.row :
            
            self.performSegueWithIdentifier("info2", sender: self)
            //
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            if  var results = objects {
                
                var match = results[indexPath.row] as! NSManagedObject
                
                var e = indexPath.row as NSNumber!
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(sln[indexPath.row], forKey: defaultsKeys.bkid)
                
                
                
            }
            break;
            
            
        default:
            
            println("\(indexPath.row) is selected");
            
        }
        
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            
            
            
            if  var results = objects {
                
                
                if results.count > 0 {
                    let match = results[sln[indexPath.row]] as! NSManagedObject
                    
                    self.managedObjectContext?.deleteObject(match)
                    
                    match.managedObjectContext?.save(&error)
                    
                    if let index = find(sln, indexPath.row) {
                        sln.removeAtIndex(index)
                    }

                    
                    
                    viewDidLoad()
                    tableView.reloadData()
                    
                }
                
            }else{
                println("error")
            }
            
            if objects!.count > 0{
                if objects!.count == 1{
                    setEditing(false, animated: true)
                    self.Barbtn.title = ""
                    self.Barbtn.image = UIImage(named: "")
                    
                }else{
                    if Barbtn_Click == 1{
                        setEditing(true, animated: true)
                    }else{
                        setEditing(false, animated: true)
                    }
                    
                }}

            
            println("DELETED")
        }
    }
    
      
    @IBAction func Deletecell(sender: AnyObject) {
        
        if tableView.editing {
            setEditing(false, animated: true)
            Barbtn_Click = 0
        } else {
            Barbtn_Click = 1 
            setEditing(true, animated: true)
            
        }
        
    }
    override func setEditing (editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if (self.editing) {
            
           
            self.Barbtn.title = "Done"
            self.Barbtn.image = UIImage(named: "")
            
        }
        else {
            
           
            self.Barbtn.title = ""
            self.Barbtn.image = UIImage(named: "Minus_icon")
            
        }
    }

    
}