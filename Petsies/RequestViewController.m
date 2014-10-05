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

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

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
    NSArray *images = @[
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"walk"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"signout"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %i",index);
    
    if (index == 1) {
        [self performSegueWithIdentifier:@"showWalk" sender:self];
    }
    
    else if (index == 3) {
        [self performSegueWithIdentifier:@"backToHome" sender:self];
    }

}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

@end
