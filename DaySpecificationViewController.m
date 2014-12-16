//
//  DaySpecificationViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 16.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "DaySpecificationViewController.h"
#import "Tagesangebot.h"
#import "Produkt.h"
#import "DaySpecificationTableViewCell.h"

@interface DaySpecificationViewController ()

@end

@implementation DaySpecificationViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api/tagesangebot"]

@synthesize listOfDaySpecification;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAllDaySpecification];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [listOfDaySpecification count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    DaySpecificationTableViewCell *cell = (DaySpecificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    Tagesangebot *ta = [self.listOfDaySpecification objectAtIndex:indexPath.row];

    
    cell.lb_daySpecificationtName.text = ta.bezeichnung;
    
    NSString *preis = [NSString stringWithFormat:@"Angebotspreis: %@", ta.preis];
    
    cell.lb_price.text = preis;
    
    
    return cell;
}


//Produkte aus dem Backend laden
-(void)getAllDaySpecification{
    
    listOfDaySpecification = nil;
    NSError *error = nil;
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@", SimplePaySeviceURL];
    
    NSURL *url = [[NSURL alloc] initWithString:serviceURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    
    if(!error){
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:&error];
        
        listOfDaySpecification = [NSMutableArray array];
        
        
        for (NSDictionary* dict in json){
            
            NSDictionary *tagesAngebot = [dict objectForKey:@"Tagesangebot_Produkt"];
            
            Tagesangebot *ta = [[Tagesangebot alloc] init];
            ta.listOfProducts = [[NSMutableArray alloc] init];
            
            NSInteger ta_id = [[dict objectForKey:@"ta_id"]integerValue];
            NSString *bezeichnung = [dict objectForKey:@"bezeichnung"];
            
            //Preis
            NSNumberFormatter *currencyformatter = [[NSNumberFormatter alloc] init];
            [currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            
            NSString *price = [currencyformatter stringFromNumber: [dict objectForKey:@"preis"]];
            
            ta.ta_id = ta_id;
            ta.bezeichnung = bezeichnung;
            ta.preis = price;
            
            for (NSDictionary* t in tagesAngebot){
                
                Produkt *p = [[Produkt alloc] init];
            
                NSDictionary *produkt = [t objectForKey:@"Produkt"];
            
                NSInteger p_id = [[produkt objectForKey:@"p_id"]integerValue];
                NSString *Pbezeichnung = [produkt objectForKey:@"bezeichnung"];
                NSNumber *preis = [produkt objectForKey:@"preis"];
                NSString *mengeneinheit = [produkt objectForKey:@"mengeneinheit"];
            
                p.p_id = p_id;
                p.bezeichnung = Pbezeichnung;
                p.preis = preis;
                p.mengeneinheit = mengeneinheit;
            
                [ta.listOfProducts addObject:p];
            
            }
            
            [listOfDaySpecification addObject:ta];
            
        }
        
    }
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
