//
//  TaxiDetailsViewController.m
//  CallATaxi
//
//  Created by Doncho Minkov on 12/19/13.
//  Copyright (c) 2013 minkovit. All rights reserved.
//

#import "TaxiDetailsViewController.h"

@interface TaxiDetailsViewController ()

@end

@implementation TaxiDetailsViewController

@synthesize taxi;

@synthesize loadingDataView;

@synthesize initialDailyLabel;
@synthesize initialNIghtlyLabel;

@synthesize perKmDailyLabel;
@synthesize perKmNightlyLabel;

@synthesize perMinDailyLabel;
@synthesize perMinNightlyLabel;

@synthesize bookingDailyLabel;
@synthesize bookingNightlyLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    persister.delegate = self;
    self.title = @"Taxi details";
    self.nameLabel.text = self.taxi.name;
    [self loadTaxiDetails];
    
    [self.view addSubview:self.loadingDataView];
}

-(void) loadTaxiDetails{
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/taxis/%d", self.taxi.taxiId];
    [persister fetchData:url withAlias:@"taxidetails"];
}

-(void) didReceiveData:(NSDictionary *)data withAlias:(NSString *)alias {
    if([alias isEqualToString:@"taxidetails"]){
        self.taxi = [[TaxiModel alloc] initWithDictionary:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            //Remove comment to hide the spinner
            [self.loadingDataView removeFromSuperview];
            
            self.ratingVotesLabel.text = [NSString stringWithFormat:@"%.2f / %d", self.taxi.rating, self.taxi.totalVotes];
            
            self.initialDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyInitial];
            self.perKmDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyPerKm];
            self.perMinDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyPerMinute];
            self.bookingDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyBooking];
            
            self.initialNIghtlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyInitial];
            self.perKmNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyPerKm];
            self.perMinNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyPerMinute];
            self.bookingNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyBooking];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.loadingDataView removeFromSuperview];
                self.commentsButton.titleLabel.text = [NSString stringWithFormat:@"View %d comments", self.taxi.comments.count];
            });
        });
    }
    else if([alias isEqualToString:@"taxiliked"]){
        NSString *title = @"Taxi liked!";
        NSString *message = [NSString stringWithFormat:@"%@ successfully liked", self.taxi.name];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
    else if([alias isEqualToString:@"taxidisliked"]){
        NSString *title = @"Taxi disliked!";
        NSString *message = [NSString stringWithFormat:@"%@ successfully disliked", self.taxi.name];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
}

-(void) didHappenedError:(NSDictionary *)error withAlias:(NSString *)alias{
    if([alias isEqualToString:@"taxiliked"] || [alias isEqualToString:@"taxidisliked"]){
        UIAlertView *alertView = [[UIAlertView alloc]init];
        [alertView addButtonWithTitle:@"Ok"];
        [alertView setTitle:@"Taxi already voted for"];
        [alertView setMessage:[NSString stringWithFormat:@"You have already voted for %@", self.taxi.name]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
}
- (IBAction)callTapped:(id)sender{
    //Test on device
    NSString *telStr =[NSString stringWithFormat:@"tel:%@",self.taxi.tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
}

- (IBAction)visitSiteTapped:(id)sender{
    //Test on device
    NSString *siteString =[NSString stringWithFormat:@"%@",self.taxi.webSite];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:siteString]];
}

- (IBAction)saveTapped:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]init];
    [alertView addButtonWithTitle:@"Ok"];
    
    if([self checkTaxiAlreadyInAddressBook])
    {
        [alertView setTitle:@"The taxi already in Address Book" ];
        [alertView setMessage:[NSString stringWithFormat:@"You already have %@ in your Address Book", self.taxi.name]];
    }
    else{
        if([self saveTaxiToAddressBook]){
            [alertView setTitle:@"Taxi contact saved" ];
            [alertView setMessage:[NSString stringWithFormat:@"%@ successfully saved to your Address Book", self.taxi.name]];
        }
        else{
            [alertView setTitle:@"Taxi not saved" ];
            [alertView setMessage:[NSString stringWithFormat:@"%@ cannot be saved to your Address Book. Please, try again later", self.taxi.name]];
        }
    }
    [alertView show];
}

- (IBAction)commentsTapped:(id)sender {
    NSLog(@"Comments tapped");
}

- (IBAction)likeTapped:(id)sender{
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/taxis/%d/like", self.taxi.taxiId];
    [persister updateDate:url withAlias:@"taxiliked" withData:nil];
}

- (IBAction)dislikeTapped:(id)sender{
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/taxis/%d/dislike", self.taxi.taxiId];
    [persister updateDate:url withAlias:@"taxidisliked" withData:nil];
}

-(BOOL) saveTaxiToAddressBook{
    CFErrorRef error = NULL;
    ABAddressBookRef iPhoneAddressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef newTaxiContact = ABPersonCreate();
    
    ABRecordSetValue(newTaxiContact, kABPersonFirstNameProperty, (__bridge CFTypeRef)(self.taxi.name), &error);
    ABRecordSetValue(newTaxiContact, kABPersonLastNameProperty, @"taxi", &error);
    
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(self.taxi.tel), kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newTaxiContact, kABPersonPhoneProperty, multiPhone,nil);
    
    CFRelease(multiPhone);
    ABAddressBookAddRecord(iPhoneAddressBook, newTaxiContact, &error);
    ABAddressBookSave(iPhoneAddressBook, &error);
    
    CFRelease(newTaxiContact);
    CFRelease(iPhoneAddressBook);
    
    
    if (error != NULL)
    {
        CFStringRef errorDesc = CFErrorCopyDescription(error);
        NSLog(@"Contact not saved: %@", errorDesc);
        CFRelease(errorDesc);
        return NO;
    }
    return YES;
}

-(BOOL) checkTaxiAlreadyInAddressBook{
    NSUInteger i;
    NSUInteger k;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    NSArray *contacts = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for (i=0; i<[contacts count]; i++ )
    {
        ABRecordRef contact = (__bridge ABRecordRef)[contacts objectAtIndex:i];
        ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue(contact, kABPersonPhoneProperty);
        CFIndex phoneNumberCount = ABMultiValueGetCount(phoneNumbers );
        
        for ( k=0; k<phoneNumberCount; k++ )
        {
            CFStringRef phoneNumberLabel = ABMultiValueCopyLabelAtIndex( phoneNumbers, k );
            CFStringRef phoneNumberValue = ABMultiValueCopyValueAtIndex( phoneNumbers, k );
            
            if([self.taxi.tel isEqualToString:(__bridge NSString *)(phoneNumberValue)]){
                
                CFRelease(addressBook);
                return YES;
            }
            
            CFRelease(phoneNumberLabel);
            CFRelease(phoneNumberValue);
        }
    }
    CFRelease(addressBook);
    return NO;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"taxiCommentsSeque"]){
        CommentsTableViewController *vm = segue.destinationViewController;
        vm.taxi = self.taxi;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
