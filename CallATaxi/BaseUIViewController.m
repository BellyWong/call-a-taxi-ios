//
//  BaseUIViewController.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/29/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController
@synthesize loadingDataView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!persister){
        persister = [[DataPersister alloc] init];
    }
    
    [self initActivityIndicator];
	// Do any additional setup after loading the view.
}

-(void) initActivityIndicator{
    self.loadingDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 367)];
    //loadingDataView.alpha = 0.4;
    self.loadingDataView.backgroundColor = [UIColor colorWithRed:55 green:55 blue:55 alpha:0.4f];
    UIView *viewWithSpinner = [[UIView alloc] initWithFrame:CGRectMake(110, 106, 100, 100)];
    [viewWithSpinner.layer setCornerRadius:15.0f];
    viewWithSpinner.backgroundColor = [UIColor blackColor];
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 90, 20)];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5, 5, 90, 70)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [spinner startAnimating];
    msg.text = @"Loading Data";
    msg.font = [UIFont systemFontOfSize:14];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.textColor = [UIColor whiteColor];
    msg.backgroundColor = [UIColor clearColor];
    viewWithSpinner.opaque = NO;
    viewWithSpinner.backgroundColor = [UIColor blackColor];
    [viewWithSpinner addSubview:spinner];
    [viewWithSpinner addSubview:msg];
    [self.loadingDataView addSubview:viewWithSpinner];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
