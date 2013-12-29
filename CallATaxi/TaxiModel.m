//
//  TaxiModel.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "TaxiModel.h"

@implementation TaxiModel

@synthesize taxiId;
@synthesize name;
@synthesize likes;
@synthesize dislikes;
@synthesize desc;
@synthesize fares;
@synthesize tel;
@synthesize webSite;
@synthesize alreadyLiked;


-(id) init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(id) initWithDictionary: (NSDictionary *) dict{
    self = [super init];
    if(self){
        /*
         DailyBookingFare = "0.7";
         DailyInitialFare = 70;
         DailyKmFare = "0.89";
         DailyMinFare = "0.26";
         Description = "Green Taxi";
         Disliked = 0;
         Dislikes = 0;
         Id = 8;
         Liked = 0;
         Likes = 0;
         Name = GreenTaxi;
         NightlyBookingFare = "0.7";
         NightlyInitialFare = "0.7";
         NightlyKmFare = "0.99";
         NightlyMinFare = "0.26";
         Telephone = 0878810810;

         */
        self.taxiId = [[dict objectForKey:@"Id"] integerValue];
        self.name = [dict objectForKey:@"Name"];
        self.likes = [[dict objectForKey:@"Likes"] integerValue];
        self.dislikes = [[dict objectForKey:@"Dislikes"] integerValue];
        
        self.desc = ([dict valueForKey:@"Description"] !=nil)?[dict valueForKey :@"Description"] :@"No desc";
        
        if([dict objectForKey:@"Telephone"]){
            self.tel = [dict objectForKey:@"Telephone"];
        }
        
        if([dict objectForKey:@"WebSite"]){
            self.webSite= [dict objectForKey:@"WebSite"];
        }
        
        if([dict objectForKey:@"DailyBookingFare"]){
            self.dailyBooking = [[dict objectForKey:@"DailyBookingFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyInitialFare"]){
            self.dailyInitial = [[dict objectForKey:@"DailyInitialFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyKmFare"]){
            self.dailyPerKm = [[dict objectForKey:@"DailyKmFare"] doubleValue];
        }
        if([dict objectForKey:@"DailyMinFare"]){
            self.dailyPerMinute = [[dict objectForKey:@"DailyMinFare"] doubleValue];
        }
        
        if([dict objectForKey:@"NightlyBookingFare"]){
            self.nightlyBooking = [[dict objectForKey:@"NightlyBookingFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyInitialFare"]){
            self.nightlyInitial = [[dict objectForKey:@"NightlyInitialFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyKmFare"]){
            self.nightlyPerKm = [[dict objectForKey:@"NightlyKmFare"] doubleValue];
        }
        if([dict objectForKey:@"NightlyMinFare"]){
            self.nightlyPerMinute = [[dict objectForKey:@"NightlyMinFare"] doubleValue];
        }
    }
    return self;
}

+(NSMutableArray *) getModelsFromDictionaries:(NSArray *) dicts{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:dicts.count];
    
    for (NSDictionary *dict in dicts) {
        TaxiModel *model = [[TaxiModel alloc] initWithDictionary:dict];
        [models addObject:model];
    }
    
    return models;
}

@end
