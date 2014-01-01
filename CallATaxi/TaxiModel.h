//
//  TaxiModel.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface TaxiModel : NSObject

@property int taxiId;
@property (strong,nonatomic) NSString *name;
@property double rating;
@property int totalVotes;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic) NSDictionary *fares;
@property (strong,nonatomic) NSString *tel;
@property (strong,nonatomic) NSString *webSite;
@property (strong,nonatomic) NSString *alreadyLiked;
@property (strong, nonatomic) NSArray *comments;

@property double dailyBooking;
@property double dailyInitial;
@property double dailyPerKm;
@property double dailyPerMinute;

@property double nightlyBooking;
@property double nightlyInitial;
@property double nightlyPerKm;
@property double nightlyPerMinute;

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


-(id) init;
-(id) initWithDictionary: (NSDictionary *) dict;

-(NSData *) toNSData;

+(NSMutableArray *) getModelsFromDictionaries:(NSArray *) dicts;

@end
