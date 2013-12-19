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
        self.taxiId = [[dict objectForKey:@"Id"] integerValue];
        self.name = [dict objectForKey:@"Name"];
        self.likes = [[dict objectForKey:@"Likes"] integerValue];
        self.dislikes = [[dict objectForKey:@"Dislikes"] integerValue];
        
       /* if([dict objectForKey:@"Description"]){
            self.desc = [dict objectForKey:@"Description"];
        }
        else{
        */
            self.desc = @"No description";
        //}
        if([dict objectForKey:@"Telephone"]){
            self.tel = [dict objectForKey:@"Telephone"];
        }
        
        if([dict objectForKey:@"WebSite"]){
            self.webSite= [dict objectForKey:@"WebSite"];
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
