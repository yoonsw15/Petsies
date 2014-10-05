//
//  FirstViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 3..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import "RequestViewController.h"

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
    //YOOJUNG TODO: search the backend and get the results.
    
    NSLog(@"Search the backend for sitters");
    
    NSDate *startDate = self.startPicker.date;
    NSDate *endDate = self.endPicker.date;
}

- (IBAction)menuTapped:(id)sender
{
    NSLog(@"Menu Tapped");
}

@end
