//
//  UserProfileViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 11.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "UserProfileViewController.h"
#import "SharedUser.h"
#import "Nutzer.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

@synthesize txt_firstAndLastName;
@synthesize txt_birthday;
@synthesize txt_streetAndNumber;
@synthesize txt_postalCode;
@synthesize txt_place;

- (void)viewDidLoad {
    [super viewDidLoad];

    SharedUser *sharedManager = [SharedUser sharedManager];
    Nutzer *user = sharedManager.user;
    
    NSString *firstAndLastName = [NSString stringWithFormat:@"%@ %@", user.vorname,user.nachname];
    NSString *streetAndNumber = [NSString stringWithFormat:@"%@ %@", user.adresse.strasse ,user.adresse.hausnummer];
    NSString *postalCode = [NSString stringWithFormat:@"%ld", (long)user.adresse.plz];
    
    txt_firstAndLastName.text = firstAndLastName;
    txt_streetAndNumber.text = streetAndNumber;
    txt_place.text = user.adresse.ort;
    txt_postalCode.text = postalCode;
    txt_birthday.text = user.geburtstag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
