//
//  CityModel.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxiModel.h"

@interface CityModel : NSObject

@property int cityId;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *country;

@property double latitude;
@property double longitude;
@property (strong,nonatomic) NSArray *taxis;
@property int likes;
@property int dislikes;
@property double dailyKmFare;
@property double dailyBookingFare;
@property double dailyInitialFare;
@property double dailyMinuteFare;
@property double nightlyKmFare;
@property double nightlyBookingFare;
@property double nightlyInitialFare;
@property double nightlyMinuteFare;

-(id) init;
-(id) initWithDictionary: (NSDictionary *) dict;

+(NSMutableArray *) getModelsFromDictionaries :(NSArray *) dicts;
@end
