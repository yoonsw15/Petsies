//
//  SitterViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 4..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import <Parse/Parse.h>
#import "SitterViewController.h"

@interface SitterViewController ()

@property NSMutableArray *freeTimeData;

@end

@implementation SitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.freeTimeList.delegate = self;
    self.freeTimeData = [[NSMutableArray alloc] initWithCapacity:9];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backButtonTappedWithStartDate:(NSDate *)start AndEndDate:(NSDate *)end
{
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    [formatDate setTimeStyle:NSDateFormatterMediumStyle];
    [formatDate setDateFormat:@"EE hh:mm a"];
    NSString *startDateString = [formatDate stringFromDate:start];
    NSString *endDateString = [formatDate stringFromDate:end];
    NSString *freeTime = [NSString stringWithFormat:@"%@ - %@",startDateString, endDateString];
    
    [self.freeTimeData addObject:freeTime];
    [self.freeTimeList reloadData];
    PFObject *newSchedule = [PFObject objectWithClassName:@"SitterSchedule"];
    [newSchedule setObject:start forKey:@"startDate"];
    [newSchedule setObject:end forKey:@"endDate"];
    [newSchedule setObject:PFUser.currentUser forKey:@"userName"];
    [newSchedule saveInBackground];
//    NSLog(@"The date has been picked as start %@, end %@", [formatDate stringFromDate:start], [formatDate stringFromDate:end]);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    FreeTimeViewController *destination = (FreeTimeViewController *)[segue destinationViewController];
    destination.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.freeTimeList  dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.freeTimeData objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.freeTimeData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
