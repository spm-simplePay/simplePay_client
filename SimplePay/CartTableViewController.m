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
#import "PayPalMobile.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Bestellposition.h"
#import "Bestellung.h"
#import "KundeTisch.h"
#import "Nutzer.h"
#import "SQLResult.h"
#import "JSONHelper.h"

@interface CartTableViewController () {
    
    NSMutableArray *products;
    double totalSum;

}
@property (strong, nonatomic, readwrite) PayPalConfiguration *payPalConfiguration;
-(void) verifyCompletedPayment:(PayPalPayment *)completedPayment;

@end

@implementation CartTableViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api"]

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _payPalConfiguration = [[PayPalConfiguration alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedCart *sharedManager = [SharedCart sharedManager];
    
    products = sharedManager.products;
    
    if ([products count] == 0) {
        self.lb_totalSum.text = @"Keine Produkte im Warenkorb";
    }
    
    self.tableView.tableFooterView = [UIView new];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:
     @{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
       PayPalEnvironmentSandbox : @"AUrmCxDwuIXIOE_8bObzX37H9M_ZRB5SyDbtDdJy38uOxhCjWPcFihdmt3WB"}];
    
    // Start out working with the test environment! When you are ready, switch to PayPalEnvironmentProduction.
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
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

-(void) checkout {

    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    // Amount, currency, and description
    
    NSDecimalNumber *doubleDecimal = [[NSDecimalNumber alloc] initWithDouble:totalSum];
    
    payment.amount = doubleDecimal;

    payment.currencyCode = @"EUR";
    payment.shortDescription = @"SimplePay";
    
    // Use the intent property to indicate that this is a "sale" payment,
    // meaning combined Authorization + Capture. To perform Authorization only,
    // and defer Capture to your server, use PayPalPaymentIntentAuthorize.
    payment.intent = PayPalPaymentIntentSale;
    
    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment not processable"
                                                            message:@"The payment is not processable"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    // Create a PayPalPaymentViewController.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                   configuration:self.payPalConfiguration
                                                                        delegate:self];
    
    // Present the PayPalPaymentViewController.
    
    dispatch_async(dispatch_get_main_queue(), ^ {
            [self.navigationController presentViewController:paymentViewController animated:YES completion:nil];
    });
    


}
                      
- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment
    {
        // Send the entire confirmation dictionary
        NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                               options:0
                                                                 error:nil];
        
        // Send confirmation to your server; your server should verify the proof of payment
        // and give the user their goods or services. If the server is not reachable, save
        // the confirmation and try again later.
    }
                      
                      
#pragma mark - PayPalPayment Delegate
                      
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
    {
        // The payment was canceled; dismiss the PayPalPaymentViewController.
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Zahlung abgebrochen" message:@"Die Zahlung wurde abgebrochen"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
                      
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                                            didCompletePayment:(PayPalPayment *)completedPayment
    {
        // Payment was processed successfully; send to server for verification and fulfillment.
        [self verifyCompletedPayment:completedPayment];
        
        // clear cart
//        [Cart clearCart];
//        [self.items removeAllObjects];
//        [self.tableView reloadData];
//        
//        [(AppDelegate *)[[UIApplication sharedApplication] delegate] updateCartTabBadge];
        
        // Dismiss the PayPalPaymentViewController.
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Zahlung erfolgreich" message:@"Die Zahlung wurde erfolgreich durchgeführt"
//                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
        
        [self postOrder];
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
                                    
                                    //[self showMessage:@"User hat sich authetifiziert" withTitle:@"SimplePay"];
                                    
                                    [self checkout];
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

-(NSString*) makeOrderJson {
    
    Nutzer *user = [[Nutzer alloc] init];
    Tisch *table = [[Tisch alloc] init];
    KundeTisch *kt = [[KundeTisch alloc]init];
    Bestellung *order = [[Bestellung alloc]init];
    
    user.n_id = 1;
    table.t_id = 1;
    
    kt.tisch = table;
    kt.kunde = user;
    
    order.kunde = user;
    order.mwst_id = 1;
    order.kundeTisch = kt;
    
    order.bestellpositionen = [[NSMutableArray alloc]init];
    
    for (SharedCart *obj in products){
        
        Bestellposition *bp = [[Bestellposition alloc]init];
        bp.produkt = obj.product;
        bp.menge = obj.quantity;
        
        [order.bestellpositionen addObject:bp];
        
    }
    
    NSString *json = order.getJsonBestellung;
    
    NSLog(@"%@",json);
    
    return json;

}

-(void) postOrder {
    
    NSError *error = nil;

    NSString* JSON = [self makeOrderJson];
    
    NSLog(@"%@",JSON);
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@", SimplePaySeviceURL,@"/Bestellung"];
    
    NSLog(@"%@",serviceURL);
    
    SQLResult* result = [JSONHelper postJSONDataToURL:serviceURL JSONdata:JSON];
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:result.data
                          options:NSJSONReadingMutableContainers
                          error:&error];
    
    NSLog(@"%li",(long)result.WasSuccessful);
    
    if (result.WasSuccessful == 1) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Zahlung und Bestellung erfolgreich" message:@"Die Zahlung wurde erfolgreich durchgeführt und die Bestellung erfolgreich abgeschickt!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    
    }
}


@end
