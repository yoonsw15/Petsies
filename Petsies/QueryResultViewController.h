//
//  QueryResultViewController.h
//  Petsies
//
//  Created by Dong Joon Kim on 10/5/14.
//  Copyright (c) 2014 BruinCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *queryList;
@property NSDate *startDate;
@property NSDate *endDate;

- (void)configureStartDate:(NSDate *)startDate;
- (void)configureStartDate:(NSDate *)endDate;
@end
