//
//  FreeTimeViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 4..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import "FreeTimeViewController.h"

@interface FreeTimeViewController ()

@end

@implementation FreeTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(backButtonTappedWithStartDate:AndEndDate:)]) {
        [self.delegate backButtonTappedWithStartDate:self.startPicker.date AndEndDate:self.endPicker.date];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
