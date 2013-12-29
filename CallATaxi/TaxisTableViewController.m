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
    if(!persister){
        persister = [[DataPersister alloc] init];
        persister.delegate = self;
    }
    self.title =[NSString stringWithFormat:@"Taxis in %@",self.city.name];
    [self loadTaxisForCity];
}

-(void) loadTaxisForCity {
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/cities/%d",self.city.cityId];
    [persister fetchData:url withAlias:@"gettaxis"];
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

-(void) didReceiveData:(NSDictionary *)data withAlias:(NSString *)alias{
    if([alias isEqualToString:@"gettaxis"]){
        self.city = [[CityModel alloc] initWithDictionary:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
