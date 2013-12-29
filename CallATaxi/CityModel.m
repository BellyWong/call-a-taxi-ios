//
//  CityModel.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

@synthesize cityId;
@synthesize name;
@synthesize country;
@synthesize latitude;
@synthesize longitude;
@synthesize taxis;

@synthesize likes;
@synthesize dislikes;
@synthesize dailyKmFare;
@synthesize dailyBookingFare;
@synthesize dailyInitialFare;
@synthesize dailyMinuteFare;
@synthesize nightlyKmFare;
@synthesize nightlyBookingFare;
@synthesize nightlyInitialFare;
@synthesize nightlyMinuteFare;

-(id) init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if(self){
        self.cityId = [[dict objectForKey:@"Id"] integerValue];
        self.name = [dict objectForKey:@"Name"];
        
        if([dict objectForKey:@"Country"]){
            self.country = [dict objectForKey:@"Country"];
        }
        if([dict objectForKey:@"Latitude"]){
            self.latitude = [[dict objectForKey:@"Latitude"] doubleValue];
        }
        if([dict objectForKey:@"Longitude"]){
            self.latitude = [[dict objectForKey:@"Longitude"] doubleValue];
        }
        if([dict objectForKey:@"Taxis"]){
            self.taxis = [TaxiModel getModelsFromDictionaries:[dict objectForKey:@"Taxis"]];
        }
        if([dict objectForKey:@"Likes"]){
            self.likes = [[dict objectForKey:@"Likes"] integerValue];
        }
        if([dict objectForKey:@"Dislikes"]){
            self.dislikes = [[dict objectForKey:@"Dislikes"] integerValue];
        }
        
        if([dict objectForKey:@"DailyKmFare"]){
            self.dailyKmFare = [[dict objectForKey:@"DailyKmFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyBookingFare"]){
            self.dailyBookingFare = [[dict objectForKey:@"DailyBookingFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyInitialFare"]){
            self.dailyInitialFare= [[dict objectForKey:@"DailyInitialFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyMinFare"]){
            self.dailyMinuteFare= [[dict objectForKey:@"DailyMinFare"] doubleValue];
        }
        
        if([dict objectForKey:@"NightlyKmFare"]){
            self.nightlyKmFare = [[dict objectForKey:@"NightlyKmFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyBookingFare"]){
            self.nightlyBookingFare = [[dict objectForKey:@"NightlyBookingFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyInitialFare"]){
            self.nightlyInitialFare= [[dict objectForKey:@"NightlyInitialFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyMinFare"]){
            self.nightlyMinuteFare= [[dict objectForKey:@"NightlyMinFare"] doubleValue];
        }
    }
    return self;
}

+(NSMutableArray *) getModelsFromDictionaries:(NSArray *)dicts{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:dicts.count];
    for (int i = 0;i< dicts.count; i++) {
        CityModel *model = [[CityModel alloc] initWithDictionary:[dicts objectAtIndex:i]];
        [models addObject:model];
    }
    return models;
}
@end
