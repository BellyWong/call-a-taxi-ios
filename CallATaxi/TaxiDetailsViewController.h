//
//  TaxiDetailsViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "TaxiModel.h"
#import "DataPersister.h"
#import <AddressBook/AddressBook.h>

@interface TaxiDetailsViewController:BaseUIViewController<DataPersisterDelegate>

@property (strong, nonatomic) TaxiModel *taxi;

@property (strong, nonatomic) UIView* loadingDataView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *initialDailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *initialNIghtlyLabel;

@property (weak, nonatomic) IBOutlet UILabel *perKmDailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *perKmNightlyLabel;

@property (weak, nonatomic) IBOutlet UILabel *perMinDailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *perMinNightlyLabel;

@property (weak, nonatomic) IBOutlet UILabel *bookingDailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingNightlyLabel;


- (IBAction)callTapped:(id)sender;
- (IBAction)visitSiteTapped:(id)sender;
- (IBAction)likeTapped:(id)sender;
- (IBAction)dislikeTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end
