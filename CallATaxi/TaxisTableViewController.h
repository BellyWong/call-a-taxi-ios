//
//  TaxisViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/18/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "TaxiModel.h"

@interface TaxisTableViewController : UITableViewController

@property (strong, nonatomic) CityModel *city;

@end
