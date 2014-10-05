//
//  LoginViewController.m
//  Petsies
//
//  Created by Jennifer Jo on 10/4/14.
//  Copyright (c) 2014 BruinCS. All rights reserved.
//

#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "RequestViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *activeField;
@property (nonatomic, strong) NSNotificationCenter *notif;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerForKeyboardNotifications];
    
    self.email.delegate = self;
    self.password.delegate = self;
    
    self.background.image = [UIImage imageNamed:@"4.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:self.email.text password:self.password.text block:^(PFUser *user, NSError *error) {
        if(user) {
            UITabBarController *vc;
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarVC"];
            
            [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self presentViewController:vc animated:YES completion:nil];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.email.text forKey:@"email"];
            [ud setObject:self.password.text forKey:@"password"];
        }else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LoginSuccessful"]){
        RequestViewController *detVC = segue.destinationViewController;
    }
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
        [self.scrollView setContentOffset:CGPointMake(0, kbSize.height) animated:YES];
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

- (IBAction)dismissKeyboard:(id)sender {
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)dealloc
{
    self.notif = nil;
}


@end
