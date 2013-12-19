//
//  TaxiDetailsViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaxiModel.h"

@interface TaxiDetailsViewController : UIViewController

@property (strong, nonatomic) TaxiModel *taxi;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (IBAction)callTapped:(id)sender;
- (IBAction)visitSiteTapped:(id)sender;
- (IBAction)likeTapped:(id)sender;
- (IBAction)dislikeTapped:(id)sender;

@end
