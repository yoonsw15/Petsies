//
//  LoginViewController.m
//  Petsies
//
//  Created by Jennifer Jo on 10/4/14.
//  Copyright (c) 2014 BruinCS. All rights reserved.
//

#import "LoginViewController.h"

UIGestureRecognizer *tapper;

@implementation LoginViewController

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


@end
