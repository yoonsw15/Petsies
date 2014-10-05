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

@interface RegisterViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *activeField;
@property (nonatomic, strong) NSNotificationCenter *notif;

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
    
    self.cvv.delegate = self;
    self.zipCode.delegate = self;
    
    [self.view addGestureRecognizer:tapper];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    self.notif = [NSNotificationCenter defaultCenter];
    
    [self.notif addObserver:self
                   selector:@selector(keyboardWasShown:)
                       name:UIKeyboardDidShowNotification object:nil];
    
    [self.notif  addObserver:self
                    selector:@selector(keyboardWillBeHidden:)
                        name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView setContentOffset:CGPointMake(0, kbSize.height/2) animated:YES];
    }
    
    if ([self.activeField isEqual:self.cvv]) {
        [self.scrollView setContentOffset:CGPointMake(0, kbSize.height/2) animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}


- (void)dealloc
{
    self.notif = nil;
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
