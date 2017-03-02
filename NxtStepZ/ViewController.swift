//
//  ViewController.swift
//  GuillotineMenu
//
//  Created by Maksym Lazebnyi on 3/24/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

import UIKit



@objc class ViewController: UIViewController {

    let reuseIdentifier = "ContentCell"
    private let cellHeight: CGFloat = 210
    private let cellSpacing: CGFloat = 20

    @IBOutlet var barButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        var urlstring="http://nxtstepz.com/webservice/webservice.php?oper=getallactivities&userid=9&type=1&page=0";
        
          WSHelper.downloadAsycData(urlstring, andReqType: 1);
        
        
      //  let w:WebHelper = WebHelper.downloadData();
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Your Menu View Controller vew must know the following data for the proper animatio
        let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = self.navigationItem.title
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
    }
    
    
    func parseActivities(receivedArray: Array<String>){
        
        
        NSLog("called swift class ");
        
        
//        for (kind, value) in receivedArray{
//            
//            let posObj = Post.new();
//            let poOb ;
//           // Post poss;
//            poOb = Post.getByPostId(NSNumber(integer: value));
//
//            poOb = [Post getByPostId:[NSNumber numberWithInt:[[dict objectForKey:@"id"] intValue]]];
//            
//            if (po == nil) {
//                
//                poss = [Post MR_createEntity];
//                
//            }
//            
//            poss.category_name = [[dict objectForKey:@"category_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"category_name"];
//            poss.comment_count = [[dict objectForKey:@"comment_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_count"] intValue]];
//            poss.company_college_name = [dict objectForKey:@"company/college_name"];
//            poss.createdDate = [NSDate date];
//            poss.firstname = [[dict objectForKey:@"firstname"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"firstname"];
//            poss.from_date = [NSDate date];
//            poss.from_time = [NSDate date];
//            poss.to_date = [NSDate date];
//            poss.to_tim = [NSDate date];
//            poss.ids = [[dict objectForKey:@"id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[dict objectForKey:@"id"] intValue]];
//            poss.imagename = [[dict objectForKey:@"imagename"] isEqual:[NSNull null]] ? @"" :[dict objectForKey:@"imagename"];
//            poss.last_name = [[dict objectForKey:@"last_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"last_name"];
//            poss.like_count = [[dict objectForKey:@"like_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"like_count"] intValue]];
//            poss.likeflag = [[dict objectForKey:@"likeflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"likeflag"] intValue]];
//            poss.likeid = [[dict objectForKey:@"likeid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"likeid"] intValue]];
//            poss.post_description = [[dict objectForKey:@"post_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"post_description"];
//            poss.post_title = [[dict objectForKey:@"post_title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"post_title"];
//            poss.post_type_id = [[dict objectForKey:@"post_type_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"post_type_id"] intValue]];
//            poss.post_type_name = [dict objectForKey:@"post_type_name"];
//            poss.profileimagename = [[dict objectForKey:@"profileimagename"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"profileimagename"];
//            poss.savedflag = [[dict objectForKey:@"savedflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"savedflag"] intValue]];
//            poss.savedid = [[dict objectForKey:@"savedid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"savedid"] intValue]];
//            poss.user_id = [[dict objectForKey:@"user_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"user_id"] intValue]];
//            poss.venue = [[dict objectForKey:@"venue"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"venue"];
//            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//            
//        }
//        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:1]] mutableCopy];
  
    
    
    }
    
}

// The follwing is just for the presentation. You can ignore it

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: AnyObject? = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        return cell as! UICollectionViewCell!
    }

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds) - cellSpacing, cellHeight)
    }

}
