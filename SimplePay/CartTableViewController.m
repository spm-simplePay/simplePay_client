//
//  CartTableViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "CartTableViewController.h"
#import "SharedCart.h"
#import "CartTableViewCell.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface CartTableViewController () {
    
    NSMutableArray *products;
    double totalSum;

}

@end

@implementation CartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedCart *sharedManager = [SharedCart sharedManager];
    
    products = sharedManager.products;
    
    if ([products count] == 0) {
        self.lb_totalSum.text = @"Keine Produkte im Warenkorb";
    }
    
    self.tableView.tableFooterView = [UIView new];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [products count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *CellIdentifier = @"Cell";
    
    CartTableViewCell *cell = (CartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    UITableViewCell *cell = (UITableViewCell *)[self.cartTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        //cell = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    SharedCart *cartObject = [products objectAtIndex:indexPath.row];
    
    
    NSNumberFormatter *currencyformatter = [[NSNumberFormatter alloc] init];
    [currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *sum = @([cartObject.product.preis doubleValue] * cartObject.quantity);
    
    NSString *price = [currencyformatter stringFromNumber:sum];
    
    cell.lb_productName.text = cartObject.product.bezeichnung;
    cell.lb_quantity.text = [NSString stringWithFormat:@"%li x %@", (long)cartObject.quantity,cartObject.product.mengeneinheit];
    cell.lb_sum.text = [NSString stringWithFormat:@"%@", price];
    
    
    totalSum = totalSum + [sum doubleValue];
    
    NSNumber *mynumber = [ NSNumber numberWithFloat:totalSum];
    
    NSString *totalPrice = [currencyformatter stringFromNumber:mynumber];
    
    self.lb_totalSum.text = [NSString stringWithFormat:@"Summe: %@", totalPrice];
    
    return cell;
    
}


-(void) startTouchID{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Zum Authentifizieren Bitte den Finger benutzen!";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL succes, NSError *error) {
                                
                                if (succes) {
                                    
                                    //[self showAlertViewWithTitle:@"Authentifizierung erfolgreich" andMessage:@"Hat funktioniert!"];
                                    
                                    [self showMessage:@"User hat sich authetifiziert" withTitle:@"SimplePay"];
                                    NSLog(@"User authenticated");
                                    
                                } else {
                                    
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            [self showMessage:@"Authentifizierung fehlgeschlagen" withTitle:@"SimplePay"];
                                            NSLog(@"Authentication Failed");
                                            break;
                                            
                                        case LAErrorUserCancel:
                                            [self showMessage:@"Authentifizierung abgebrochen" withTitle:@"SimplePay"];
                                            NSLog(@"User pressed Cancel button");
                                            break;
                                            
                                        case LAErrorUserFallback:
                                            [self showMessage:@"Passwort-Eingabe in Bearbeitung" withTitle:@"SimplePay"];
                                            NSLog(@"User pressed \"Enter Password\"");
                                            break;
                                            
                                        default:
                                           [self showMessage:@"Error" withTitle:@"SimplePay"];
                                            NSLog(@"Touch ID is not configured");
                                            break;
                                    }
                                    
                                    NSLog(@"Authentication Fails");
                                }
                            }];
        
    } else {
        NSLog(@"Can not evaluate Touch ID");
        [self showMessage:@"Error" withTitle:@"SimplePay"];
    }
    
}

-(void) showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_actionClearAllCartObjects:(id)sender {
    
    [products removeAllObjects];
    [self.tableView reloadData];
    totalSum = 0.0;
    self.lb_totalSum.text = @"Keine Produkte im Warenkorb";
    
}

- (IBAction)btn_actionPostOrder:(id)sender {
    [self startTouchID];
}
@end
