//
//  CommentModel.h
//  CallATaxi
//
//  Created by Doncho Minkov on 12/31/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *user;

-(id) initWithDictionary: (NSDictionary *) dict;

+(NSArray *) getModelsFromDictionaries: (NSDictionary *) dicts;
@end
