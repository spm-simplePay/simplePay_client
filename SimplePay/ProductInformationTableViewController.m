//
//  ProductInformationTableViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "ProductInformationTableViewController.h"
#import "SharedCart.h"

@interface ProductInformationTableViewController () {

    double quantity;
}


@end

@implementation ProductInformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumberFormatter *currencyformatter = [[NSNumberFormatter alloc] init];
    [currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *price = [currencyformatter stringFromNumber:self.product.preis];
    
    //default Anzahl
    quantity = 1;
    
    self.lb_label.text = self.product.bezeichnung;
    self.lb_price.text = price;
    self.lb_quantityUnit.text = self.product.mengeneinheit;
    
    self.lb_sum.text = price;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(UIStepper *)sender {
    
    quantity = [sender value];
    
    [self.lb_quantity setText:[NSString stringWithFormat:@"%d", (int)quantity]];
    

    NSNumberFormatter *currencyformatter = [[NSNumberFormatter alloc] init];
    [currencyformatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *sum = @([self.product.preis doubleValue] * quantity);
    
    NSString *price = [currencyformatter stringFromNumber:sum];
    
    self.lb_sum.text = [NSString stringWithFormat:@"%@", price];
}

-(void)addProductToCart: (Produkt *) p_product :(NSInteger) p_quantity {
    
    SharedCart *sharedManager = [SharedCart sharedManager];
    
    SharedCart *cart = [[SharedCart alloc] init];
    
    cart.product = p_product;
    cart.quantity = p_quantity;
    
    [sharedManager.products addObject:cart];

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

- (IBAction)btn_actionAddToCart:(id)sender {
    
    [self addProductToCart:self.product :quantity];
}
@end
