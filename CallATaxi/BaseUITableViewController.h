//
//  BaseTableViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/29/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataPersister.h"

@interface BaseUITableViewController : UITableViewController
{
    DataPersister *persister;
}

@property (strong, nonatomic) UIView* loadingDataView;

@end
