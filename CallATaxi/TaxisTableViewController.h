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
#import "DataPersister.h"
#import "BaseUITableViewController.h"

@interface TaxisTableViewController : BaseUITableViewController<DataPersisterDelegate>

@property (strong, nonatomic) CityModel *city;

@end
