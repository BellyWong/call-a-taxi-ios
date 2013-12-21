//
//  TaxiDetailsViewController.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "TaxiDetailsViewController.h"

@interface TaxiDetailsViewController ()

@end

@implementation TaxiDetailsViewController

@synthesize taxi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.taxi.name;
    [self loadTaxiDetails];
}

-(void) loadTaxiDetails{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://callataxi.apphb.com/api/taxis/%d", self.taxi.taxiId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"test-phoneid" forHTTPHeaderField:@"x-phoneId"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *taxiDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.taxi = [[TaxiModel alloc] initWithDictionary:taxiDict];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.descLabel.text = self.taxi.desc;
        });
    }];
}

- (IBAction)callTapped:(id)sender{
    NSString *telStr =[NSString stringWithFormat:@"tel:%@",self.taxi.tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
}
- (IBAction)visitSiteTapped:(id)sender{
}
- (IBAction)likeTapped:(id)sender{
}

- (IBAction)saveTapped:(id)sender {
}
- (IBAction)dislikeTapped:(id)sender{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
