//
//  FirstViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 3..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import <Parse/Parse.h>
#import "RequestViewController.h"
#import "QueryResultViewController.h"

@interface RequestViewController ()

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)queryForSitters:(id)sender {
    
    NSMutableArray *queryResultData = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSDate *startDate = self.startPicker.date;
    NSDate *endDate = self.endPicker.date;
    
    PFQuery *query = [PFQuery queryWithClassName:@"SitterSchedule"];
    [query whereKey:@"startDate" lessThanOrEqualTo:startDate];
    [query whereKey:@"endDate" greaterThanOrEqualTo:endDate];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for ( NSInteger i = 0 ; i < [objects count] ; i++ ){
                PFUser *user = (PFUser *)[[objects objectAtIndex:i] objectForKey:@"userName"];
                PFUser *user2 = [PFQuery getUserObjectWithId:user.objectId];
                [queryResultData addObject:user2.username];
                NSLog(@"%@", user2.username);
            }
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:queryResultData forKey:@"queryResult"];
            [ud setObject:startDate forKey:@"latestStartDate"];
            [ud setObject:endDate forKey:@"latestEndDate"];
            [ud synchronize];
            
            QueryResultViewController *vc;
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"queryResultVC"];

            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (IBAction)menuTapped:(id)sender
{
    NSLog(@"Menu Tapped");
}

@end
