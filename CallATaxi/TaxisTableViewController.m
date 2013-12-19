//
//  TaxisViewController.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/18/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "TaxisTableViewController.h"
#import "TaxiDetailsViewController.h"

@interface TaxisTableViewController ()

@end

@implementation TaxisTableViewController

@synthesize city;

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
    self.title =[NSString stringWithFormat:@"Taxis in %@",self.city.name];
    [self loadTaxisForCity];
}

-(void) loadTaxisForCity {
    int cityId = self.city.cityId;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://callataxi.apphb.com/api/cities/%d", cityId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *cityDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.city = [[CityModel alloc] initWithDictionary:cityDict];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.city.taxis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text =[[self.city.taxis objectAtIndex:indexPath.row] name];
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"taxiDetailsSegue"]){
        TaxiDetailsViewController *vc = segue.destinationViewController;
        long selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        TaxiModel *selectedTaxi = [self.city.taxis objectAtIndex:selectedIndex];
        vc.taxi = selectedTaxi;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
