//
//  CommentsViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 1/1/14.
//  Copyright (c) 2014 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUITableViewController.h"
#import "TaxiModel.h"

@interface CommentsTableViewController : BaseUITableViewController<DataPersisterDelegate>

@property (strong, nonatomic) TaxiModel *taxi;

@end

