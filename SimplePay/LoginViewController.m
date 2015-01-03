//
//  ViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "LoginViewController.h"
#import "Nutzer.h"
#import "SQLResult.h"
#import "JSONHelper.h"
#import "SharedUser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api"]

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_actionLogin:(id)sender {
    
    [self postUserLogin];
}


-(void) postUserLogin {
    
    NSError *error = nil;
    
    if([self textFieldValidation:[self view]]){
        
        Nutzer *user = [[Nutzer alloc] init];
        user.email = self.txt_email.text;
        user.passwort = self.txt_password.text;
        
        NSString *JSON = [user getJsonUserLogin];
        
        NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SimplePaySeviceURL,@"/Login"];
        
        NSLog(@"%@",serviceURL);
        
        SQLResult* result = [JSONHelper postJSONDataToURL:serviceURL JSONdata:JSON];
        
        
        if(result.WasSuccessful == 1) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainTabBarController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
            
            //User in der Shared-Variable speichern
            
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:result.data
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
            
            Nutzer *loggedInUser = [[Nutzer alloc] init];
            loggedInUser.n_id = [[json objectForKey:@"n_id"]integerValue];
            
            SharedUser *sharedManager = [SharedUser sharedManager];
            sharedManager.user = loggedInUser;
        
        }else {
            [self showAlertViewWithTitle:@"Login" andMessage:@"Email oder Passwort falsch!"];
        }
        
    
    } else {
        [self showAlertViewWithTitle:@"Validierung" andMessage:@"Bitte alle Felder ausfüllen"];
    }

}

-(IBAction)removeKeyboard {
    //Platzhalter um die Tastatur zu schließen
    //Hier kann man auch ein Code schreiben
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
@end
