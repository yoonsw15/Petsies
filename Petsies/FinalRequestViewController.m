//
//  FinalRequestViewController.m
//  Petsies
//
//  Created by Dong Joon Kim on 10/5/14.
//  Copyright (c) 2014 BruinCS. All rights reserved.
//

#import <Parse/Parse.h>
#import "FinalRequestViewController.h"

@interface FinalRequestViewController ()

@end

@implementation FinalRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finalRequest:(id)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    PFObject *newRequest = [PFObject objectWithClassName:@"Request"];
//    [newRequest setObject:[ud objectForKey:@"latestStartTime"] forKey:@"startTime"];
//    [newRequest setObject:[ud objectForKey:@"latestEndTime"] forKey:@"endTime"];
    [newRequest setObject:PFUser.currentUser forKey:@"owner"];
    PFQuery *query = [PFUser query];
    [query whereKey:@"userName" equalTo:[ud objectForKey:@"latestSitter"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFUser *user = (PFUser *)[objects firstObject];
        NSLog(@"%@", objects);
//        PFUser *user2 = [PFQuery getUserObjectWithId:user.objectId];
        [newRequest setObject:user forKey:@"sitter"];
    }];
    [newRequest saveInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
