//
//  DataPersister.h
//  PersistingData
//
//  Created by Doncho Minkov on 12/21/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataPersisterDelegate<NSObject>
@required

-(void) didReceiveData: (NSDictionary *) data withAlias:(NSString *) alias;
-(void) didHappenedError: (NSDictionary *) error withAlias: (NSString *) alias;

@end

@interface DataPersister : NSObject{
    NSDictionary* headers;
}

@property (nonatomic, strong) id<DataPersisterDelegate> delegate;

-(id) init;
-(id) initWithHeaders: (NSDictionary*) theHeaders;

-(void) fetchData: (NSString*)url withAlias: (NSString*) alias;
-(void) updateDate: (NSString*)url withAlias: (NSString*) alias withData:(NSObject*) data;
-(void) sendData: (NSString*)url withAlias: (NSString*) alias withData: (NSObject*) data;
@end