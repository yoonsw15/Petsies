//
//  ProfileViewController.h
//  Petsies
//
//  Created by SeungWon on 2014. 10. 3..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UIButton *addPhoto;
@property (strong, nonatomic) IBOutlet UITableView *petList;
@end
