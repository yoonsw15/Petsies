//
//  FreeTimeViewController.h
//  Petsies
//
//  Created by SeungWon on 2014. 10. 4..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FreeTimeViewControllerDelegate <NSObject>

@required
- (void)backButtonTappedWithStartDate:(NSDate *)start AndEndDate:(NSDate *)end;

@end

@interface FreeTimeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *startPicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *endPicker;

@property (strong, nonatomic) id<FreeTimeViewControllerDelegate>delegate;

@end
