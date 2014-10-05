//
//  LoginViewController.m
//  Petsies
//
//  Created by SeungWon on 2014. 10. 3..
//  Copyright (c) 2014년 BruinCS. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray * allImages;
@property (nonatomic, strong) NSTimer * animationTimer;
@property (nonatomic, assign) NSInteger counter;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.counter = 0;
    self.allImages = [[NSArray alloc]initWithObjects:@"1.png",@"2.png",@"3.png", @"4.png",nil];
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                target:self
                                                              selector:@selector(changeBackground)
                                                              userInfo:nil
                                                               repeats:YES];
    [self changeBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.animationTimer invalidate];
}

- (void)changeBackground
{
    self.counter = self.counter + 1;
    
    if (self.counter > 4) {
        self.counter = self.counter % 4;
    }
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         NSLog(@"%li", (long)self.counter);
                         self.background.image = [UIImage imageNamed:[NSString stringWithFormat: @"%li.jpg" , (long)self.counter]];
                     }];
}

- (IBAction)nyanClicked:(id)sender {
    UIImageView* nyanView = [[UIImageView alloc] initWithFrame:self.background.bounds];
    nyanView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"nyan1"],
                                         [UIImage imageNamed:@"nyan2"],
                                         [UIImage imageNamed:@"nyan3"],
                                         [UIImage imageNamed:@"nyan4"],[UIImage imageNamed:@"nyan5"], [UIImage imageNamed:@"nyan6"],[UIImage imageNamed:@"nyan7"],[UIImage imageNamed:@"nyan8"],[UIImage imageNamed:@"nyan9"],[UIImage imageNamed:@"nyan10"],[UIImage imageNamed:@"nyan11"],[UIImage imageNamed:@"nyan12"],nil];
    nyanView.animationDuration = 0.2f;
    nyanView.animationRepeatCount = 0;
    [nyanView startAnimating];
    [self.background addSubview: nyanView];
    
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
