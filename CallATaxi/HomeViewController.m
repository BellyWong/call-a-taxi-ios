//
//  HomeViewController.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/13/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TaxisTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


@synthesize locationLabel;
@synthesize cityLabel;

@synthesize cities;
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
    persister.delegate = self;
    [self getCurrentLocation];
    [self initServer];
    self.title = @"Home";
}

-(void) initServer{
    NSString *urlString = @"http://callataxi.apphb.com/api/init";
    [persister fetchData:urlString withAlias:@"initserver"];
}

-(void) getCurrentLocation{
    if(!locationManager){
        locationManager = [[CLLocationManager alloc]init];
    }
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *) manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations lastObject];
    dispatch_async(dispatch_get_main_queue(), ^{
        locationLabel.text = [NSString stringWithFormat:@"lat: %f, long: %f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    });
    if(!location){
        location = currentLocation;
        [self loadLocationFromServer];
    }
}

-(void) loadLocationFromServer{
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/cities?location=%f;%f", location.coordinate.latitude, location.coordinate.longitude];
    
    //NSString *url =@"http://callataxi.apphb.com/api/cities";
    
    [persister fetchData:url withAlias:@"getcities"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)chooseAnother:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    [actionSheet addSubview:pickerView];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

-(void)dismissActionSheet:(UISegmentedControl*)sender{
    UIActionSheet *actionSheet = (UIActionSheet *)[sender superview];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.cities count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.cities objectAtIndex:row] name] ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.city = [self.cities objectAtIndex:row];
    self.cityLabel.text = self.city.name;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"viewTaxisSegue"]){
        TaxisTableViewController *taxisVC = segue.destinationViewController;
        taxisVC.city = self.city;
    }
}

-(void) didReceiveData: (NSDictionary *) data withAlias:(NSString *) alias{
    if([alias isEqualToString:@"initserver"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Server is up and running");
        });
    }
    else if([alias isEqualToString:@"getcities"]){
        self.cities = [CityModel getModelsFromDictionaries:(NSArray *)data];
        self.city =  [self.cities firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            cityLabel.text =  self.city.name;
        });
        [self.loadingDataView removeFromSuperview];
    }
}
@end