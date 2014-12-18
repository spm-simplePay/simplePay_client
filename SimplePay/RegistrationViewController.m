//
//  RegistrationViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Nutzer.h"
#import "Adresse.h"
#import "Nutzerart.h"
#import "SQLResult.h"
#import "JSONHelper.h"

@interface RegistrationViewController () {

    NSString *birthday;
    
}

@end

@implementation RegistrationViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api"]

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Inputfeld "birthday" einen Datepicker zuordnen
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    self.txt_birthday.inputView = datePicker;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)removeKeyboard {
    //Platzhalter um die Tastatur zu schließen
    //Hier kann man auch ein Code schreiben
}

- (IBAction)btn_actionRegistration:(id)sender {
    
    [self postUserRegistration];
}

-(void) postUserRegistration {
    
    NSError *error = nil;
    NSInteger key = 0;
    NSString *bezeichnung;
    
    
    if([self textFieldValidation:[self view]]){
    
        Nutzer *user = [[Nutzer alloc] init];
        Nutzerart *userArt = [[Nutzerart alloc] init];
        Adresse *address = [[Adresse alloc] init];
        
        
        user.vorname = self.txt_firstName.text;
        user.nachname = self.txt_lastName.text;

        user.geburtstag = birthday;
        
        user.email = self.txt_email.text;
        user.passwort = self.txt_password.text;
        user.paypin = self.txt_payPin.text;
        
        //Nutzerart
        userArt.na_id = 1;
        
        user.nutzerart = userArt;
        
        address.strasse = self.txt_street.text;
        address.hausnummer = self.txt_number.text;
        
        
        //PLZ formatieren
        NSInteger postalCode = [self.txt_postalCode.text intValue];
        
        address.plz = postalCode;
        address.ort = self.txt_place.text;
        
        
        user.adresse = address;
        
        
        NSString* JSON = [user getJsonNutzer];
        
        NSLog(@"%@",JSON);
        
        NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SimplePaySeviceURL,@"/Reg"];
        
        NSLog(@"%@",serviceURL);
        
        SQLResult* result = [JSONHelper postJSONDataToURL:serviceURL JSONdata:JSON];
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:result.data
                              options:NSJSONReadingMutableContainers
                              error:&error];
    
        
        key = [[json objectForKey:@"Key"]integerValue];
        bezeichnung = [json objectForKey:@"Value"];
        
        
        if (key == 0) {
            [self showAlertViewWithTitle:@"Registrierung erfolgreich" andMessage:bezeichnung];
        } else {
            [self showAlertViewWithTitle:@"Registrierung fehlgeschlagen" andMessage:bezeichnung];
        }

    
    } else {
        
        [self showAlertViewWithTitle:@"Validierung" andMessage:@"Bitte alle Felder ausfüllen"];
    
    }


}

-(BOOL)textFieldValidation:(UIView*)view{
    
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]]) {
        
            UITextField *textfield = x;
            
            if([textfield.text isEqualToString:@""]){
                return NO;
            }
        }
    }
    
    return YES;
}


-(void) showAlertViewWithTitle: (NSString*)title andMessage: (NSString*) message {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];


}


-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txt_birthday.inputView;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    
    self.txt_birthday.text = [dateFormat stringFromDate:picker.date];
    
    birthday = [NSString stringWithFormat:@"%@T00:00:00", [dateFormat2 stringFromDate:picker.date]];
    
    NSLog(@"Geb:%@",birthday);
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
