//
//  TaxiModel.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiModel : NSObject

@property int taxiId;
@property (strong,nonatomic) NSString *name;
@property int likes;
@property int dislikes;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic) NSDictionary *fares;
@property (strong,nonatomic) NSString *tel;
@property (strong,nonatomic) NSString *webSite;
@property (strong,nonatomic) NSString *alreadyLiked;


-(id) init;
-(id) initWithDictionary: (NSDictionary *) dict;

+(NSMutableArray *) getModelsFromDictionaries:(NSArray *) dicts;

@end
