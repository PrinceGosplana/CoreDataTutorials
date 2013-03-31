//
//  ViewController.m
//  CoreDataTutorialz
//
//  Created by admin on 30.03.13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
{
    NSManagedObjectContext * context;
}
@end

@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [[self firstnameTextField]setDelegate:self];
    [[self lastnameTextField]setDelegate:self];
    
    AppDelegate * appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender {
    NSEntityDescription * entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *newPerson = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newPerson setValue:self.firstnameTextField.text forKey:@"firstname"];
    [newPerson setValue:self.lastnameTextField.text forKey:@"lastname"];
    
    NSError * error;
    [context save:&error];
    self.displayLabel.text = @"Person added.";
}

- (IBAction)searchButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@", self.firstnameTextField.text, self.lastnameTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <=0) {
        self.displayLabel.text = @"No Person found";
    }
    else{
        NSString *firstName;
        NSString *lastName;
        
        for (NSManagedObject *obj in matchingData) {
            firstName = [obj valueForKey:@"firstname"];
            lastName = [obj valueForKey:@"lastname"];
        }
        self.displayLabel.text = [NSString stringWithFormat: @"Firstname: %@, Lastname: %@", firstName, lastName];
    }

}

- (IBAction)deleteButton:(id)sender {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@", self.firstnameTextField.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <=0) {
        self.displayLabel.text = @"No person deleted";
    }
    else{
        int count = 0;
        for (NSManagedObject *obj in matchingData) {
            [context deleteObject:obj];
            ++count;
        }
        [context save:&error];
        self.displayLabel.text = [NSString stringWithFormat:@"%d Persons deleted", count];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
