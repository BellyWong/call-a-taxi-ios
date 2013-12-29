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
    if(!persister){
        persister = [[DataPersister alloc] init];
        persister.delegate = self;
    }
    self.title = self.taxi.name;
    [self loadTaxiDetails];
    
    [self initActivityIndicator];
    [self.view addSubview:self.loadingDataView];
}

-(void) initActivityIndicator{
    self.loadingDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 367)];
    //loadingDataView.alpha = 0.4;
    self.loadingDataView.backgroundColor = [UIColor colorWithRed:55 green:55 blue:55 alpha:0.4f];
    UIView *viewWithSpinner = [[UIView alloc] initWithFrame:CGRectMake(110, 106, 100, 100)];
    [viewWithSpinner.layer setCornerRadius:15.0f];
    viewWithSpinner.backgroundColor = [UIColor blackColor];
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 90, 20)];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5, 5, 90, 70)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [spinner startAnimating];
    msg.text = @"Loading Data";
    msg.font = [UIFont systemFontOfSize:14];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.textColor = [UIColor whiteColor];
    msg.backgroundColor = [UIColor clearColor];
    viewWithSpinner.opaque = NO;
    viewWithSpinner.backgroundColor = [UIColor blackColor];
    [viewWithSpinner addSubview:spinner];
    [viewWithSpinner addSubview:msg];
    [self.loadingDataView addSubview:viewWithSpinner];
}

-(void) loadTaxiDetails{
    NSString *url = [NSString stringWithFormat:@"http://callataxi.apphb.com/api/taxis/%d", self.taxi.taxiId];
    [persister fetchData:url withAlias:@"taxidetails"];
}

-(void) didReceiveData:(NSDictionary *)data withAlias:(NSString *)alias {
    self.taxi = [[TaxiModel alloc] initWithDictionary:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        //Remove comment to hide the spinner
        [self.loadingDataView removeFromSuperview];
        self.initialDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyInitial];
        self.perKmDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyPerKm];
        self.perMinDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyPerMinute];
        self.bookingDailyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.dailyBooking];
        
        self.initialNIghtlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyInitial];
        self.perKmNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyPerKm];
        self.perMinNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyPerMinute];
        self.bookingNightlyLabel.text = [NSString stringWithFormat:@"%.2f",self.taxi.nightlyBooking];
    });
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

- (IBAction)likeTapped:(id)sender{
}

- (IBAction)dislikeTapped:(id)sender{
}

-(BOOL) saveTaxiToAddressBook{
    CFErrorRef error = NULL;
    ABAddressBookRef iPhoneAddressBook = ABAddressBookCreateWithOptions(NULL,nil);
    
    ABRecordRef newPerson = ABPersonCreate();
    
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)(self.taxi.name), &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty, @"taxi", &error);
    
    ABMutableMultiValueRef multiPhone =     ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(self.taxi.tel), kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,nil);
    
    CFRelease(multiPhone);
    ABAddressBookAddRecord(iPhoneAddressBook, newPerson, &error);
    ABAddressBookSave(iPhoneAddressBook, &error);
    
    CFRelease(newPerson);
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
    NSArray *people = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for ( i=0; i<[people count]; i++ )
    {
        ABRecordRef person = (__bridge ABRecordRef)[people objectAtIndex:i];
        ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneNumberCount = ABMultiValueGetCount( phoneNumbers );
        
        for ( k=0; k<phoneNumberCount; k++ )
        {
            CFStringRef phoneNumberLabel = ABMultiValueCopyLabelAtIndex( phoneNumbers, k );
            CFStringRef phoneNumberValue = ABMultiValueCopyValueAtIndex( phoneNumbers, k );
            
            if([self.taxi.tel isEqualToString:(__bridge NSString *)(phoneNumberValue)]){
                return YES;
                CFRelease(addressBook);
            }
            
            CFRelease(phoneNumberLabel);
            CFRelease(phoneNumberValue);
        }
    }
    CFRelease(addressBook);
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
