//
//  CommentModel.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/31/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

@synthesize text;
@synthesize user;

-(id) initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.text = [dict objectForKey:@"Text"];
        self.user = [dict objectForKey:@"User"];
    }
    return self;
}

+(NSArray *) getModelsFromDictionaries:(NSArray*)dicts{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:dicts.count];
    for (NSDictionary *dict in dicts) {
        CommentModel *model = [[CommentModel alloc] initWithDictionary:dict];
        [models addObject:model];
    }
    
    return models;
}
@end
