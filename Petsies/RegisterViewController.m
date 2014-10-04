//
//  RegisterViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 3..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import <Parse/Parse.h>
#import "RegisterViewController.h"
#import "ProfileViewController.h"

@interface RegisterViewController ()

@end

UIGestureRecognizer *tapper;

@implementation RegisterViewController

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)nextButton:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    PFUser *user = [PFUser user];
    
    [ud setObject:self.email.text forKey:@"email"];
    [ud setObject:self.password.text forKey:@"password"];
    [ud setObject:self.name.text forKey:@"name"];
    [ud setObject:self.creditCard.text forKey:@"creditCard"];
    [ud setObject:self.cvv.text forKey:@"cvv"];
    [ud setObject:self.zipCode.text forKey:@"zipCode"];
    [ud synchronize];
    
    // use email address as username
    user.username = self.email.text;
    user.password = self.password.text;
    user.email = self.email.text;
    [user setObject:self.name.text forKey:@"name"];
    [user setObject:self.creditCard.text forKey:@"creditCard"];
    [user setObject:self.cvv.text forKey:@"CVV"];
    [user setObject:self.zipCode.text forKey:@"zipcode"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            [self performSegueWithIdentifier:@"SignupSuccessful" sender:self];
        }else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SignupSuccessful"]){
        ProfileViewController *detVC = segue.destinationViewController;
    }
}
@end
