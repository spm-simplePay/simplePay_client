//
//  OrdersTableViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import "OrdersTableViewController.h"
#import "SharedUser.h"
#import "Nutzer.h"
#import "Bestellung.h"
#import "Bestellposition.h"
#import "Produkt.h"
#import "Quittung.h"
#import "OrderPositionTableViewController.h"

@interface OrdersTableViewController ()

@end

@implementation OrdersTableViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api"]

@synthesize listOfOrders;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAllOrdersForUser];
    self.tableView.tableFooterView = [UIView new];

    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self getAllOrdersForUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listOfOrders count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     
     static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = (UITableViewCell *)[self.ordersTableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
     // Configure the cell...
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     // Display recipe in the table cell
     Quittung *q = nil;
     q= [listOfOrders objectAtIndex:indexPath.row];
     
     NSString *label = [NSString stringWithFormat:@"%@ - %@ - %@", q.datum,q.uhrzeit,q.summe];
     
     cell.textLabel.text = label;
     
     
     return cell;
     
 }
 



//Produkte aus dem Backend laden
-(void)getAllOrdersForUser{
    
    listOfOrders = nil;
    double totalSum;
    Quittung *q;
    NSError *error = nil;
    
    NSNumberFormatter *currencyformatter = [[NSNumberFormatter alloc] init];
    [currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];

    
    
    SharedUser *sharedManager = [SharedUser sharedManager];
    Nutzer *user = sharedManager.user;
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@/Quittung?k_id=%li", SimplePaySeviceURL,(long)user.n_id];
    
    NSURL *url = [[NSURL alloc] initWithString:serviceURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    

    if(!error){
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:&error];
        
        listOfOrders = [NSMutableArray array];
        
        
        for (NSDictionary* dict in json){
            
            q = [[Quittung alloc]init];
            q.bestellpositionen = [[NSMutableArray alloc]init];
            totalSum = 0.0;
            NSNumber *mynumber;
            
            NSDictionary *dictBestellposition = [dict objectForKey:@"Bestellposition"];
            
            //Datum formatieren
            NSString *datum =  [dict objectForKey:@"datum"];
            datum = [datum componentsSeparatedByString:@"T"][0];
            
            NSString *day =  [datum componentsSeparatedByString:@"-"][2];
            NSString *month =  [datum componentsSeparatedByString:@"-"][1];
            NSString *year =  [datum componentsSeparatedByString:@"-"][0];
            
            datum = [NSString stringWithFormat:@"%@.%@.%@", day,month,year];
            
            q.datum = datum;
            q.uhrzeit = [dict objectForKey:@"uhrzeit"];
            
            
            for(NSDictionary *bestellposition in dictBestellposition) {
                
                Produkt *p = [[Produkt alloc]init];
                Bestellposition *bp = [[Bestellposition alloc]init];
                
                NSDictionary *produkt = [bestellposition objectForKey:@"Produkt"];

                
                    NSString *bezeichnung = [produkt objectForKey:@"bezeichnung"];
                    NSNumber *preis = [produkt objectForKey:@"preis"];
                    NSString *mengeneinheit = [produkt objectForKey:@"mengeneinheit"];
                
                    p.bezeichnung = bezeichnung;
                    p.preis = preis;
                    p.mengeneinheit = mengeneinheit;
                
                
                
                NSInteger menge = [[bestellposition objectForKey:@"menge"]integerValue];
                
                bp.produkt = p;
                bp.menge = menge;
                
                [q.bestellpositionen addObject: bp];
                
                
                //Rechnungssumme berechnen
                
                NSNumber *sum = @([bp.produkt.preis doubleValue] * menge);
                totalSum = totalSum + [sum doubleValue];
                mynumber = [ NSNumber numberWithFloat:totalSum];
                
            }
            
            NSString *price = [currencyformatter stringFromNumber:mynumber];
            q.summe = price;
            
            
           [listOfOrders addObject:q];
            
        }
        
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    NSIndexPath *indexPath = nil;
    Quittung *q = nil;
    
    indexPath = [self.ordersTableView indexPathForSelectedRow];
    q = [listOfOrders objectAtIndex:indexPath.row];
    
    OrderPositionTableViewController *destViewController = segue.destinationViewController;
    destViewController.quittung = q;

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

@end
