//
//  HomeViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/13/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CityModel.h"

@interface HomeViewController : UIViewController<CLLocationManagerDelegate, UIPickerViewDelegate>
{
    CLLocationManager *locationManager;
    NSURLConnection *connection;
    CLLocation *location;
}
@property (strong,nonatomic) IBOutlet UILabel *locationLabel;
@property (strong,nonatomic) IBOutlet UILabel *cityLabel;

- (IBAction)chooseAnother:(id)sender;

@property (strong, nonatomic) NSMutableArray *cities;
@property (strong, nonatomic) CityModel *city;

@end
