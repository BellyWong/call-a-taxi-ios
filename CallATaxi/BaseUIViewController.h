//
//  BaseUIViewController.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/29/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "DataPersister.h"

@interface BaseUIViewController : UIViewController
{
    DataPersister *persister;
}

@property (strong, nonatomic) UIView* loadingDataView;

@end
