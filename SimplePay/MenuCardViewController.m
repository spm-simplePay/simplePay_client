//
//  MenuCardViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "MenuCardViewController.h"
#import "Produkt.h"
#import "ProductInformationTableViewController.h"

@interface MenuCardViewController ()

@end

@implementation MenuCardViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api/Produkt"]

@synthesize listOfProducts;
@synthesize searchResults;

//Beim Laden der View die Produkte aus dem Backend laden
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAllProducts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Anzahl der Produkte
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [listOfProducts count];
    }
    

}

//TableView füllen
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[self.productsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Display recipe in the table cell
    Produkt *recipe = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [searchResults objectAtIndex:indexPath.row];
    } else {
        recipe = [listOfProducts objectAtIndex:indexPath.row];
    }
    
    
    //Produkt *p = [self.listOfProducts objectAtIndex:indexPath.row];
    
    //NSString *bezeichnung = p.bezeichnung;
    
    NSString *bezeichnung = recipe.bezeichnung;
    
    
    cell.textLabel.text = bezeichnung;
    
    
    return cell;
}

//Produkte aus dem Backend laden
-(void)getAllProducts{
    
    listOfProducts = nil;
    NSError *error = nil;
    
    NSString *serviceURL = [NSString stringWithFormat:@"%@", SimplePaySeviceURL];
    
    NSURL *url = [[NSURL alloc] initWithString:serviceURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    
    if(!error){
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:&error];
        
        listOfProducts= [NSMutableArray array];
        
        
        for (NSDictionary* dict in json){
            
            Produkt *p = [[Produkt alloc] init];
            
            NSInteger p_id = [[dict objectForKey:@"p_id"]integerValue];
            NSString *bezeichnung = [dict objectForKey:@"bezeichnung"];
            NSNumber *preis = [dict objectForKey:@"preis"];
            NSString *mengeneinheit = [dict objectForKey:@"mengeneinheit"];

            p.p_id = p_id;
            p.bezeichnung = bezeichnung;
            p.preis = preis;
            p.mengeneinheit = mengeneinheit;
            
            [listOfProducts addObject:p];
            
        }
        
    }
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"bezeichnung contains[c] %@", searchText];
    searchResults = [listOfProducts filteredArrayUsingPredicate:resultPredicate];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
   // if ([segue.identifier isEqualToString:@"showProductDetail"]) {
        NSIndexPath *indexPath = nil;
        Produkt *p = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            p = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.productsTableView indexPathForSelectedRow];
            p = [listOfProducts objectAtIndex:indexPath.row];
        }
        
        ProductInformationTableViewController *destViewController = segue.destinationViewController;
        destViewController.product = p;
  //  }
    
//    
//
//    ProductInformationTableViewController *detailViewController = segue.destinationViewController;
//    
//    if (self.searchDisplayController.active) {
//        NSIndexPath *selectedRowIndexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//        detailViewController.product = [self.listOfProducts objectAtIndex:selectedRowIndexPath.row];
//
//    } else {
//        NSIndexPath *selectedRowIndexPath = [self.productsTableView indexPathForSelectedRow];
//        detailViewController.product = [self.listOfProducts objectAtIndex:selectedRowIndexPath.row];
//
//    }
//
//    
//    
//    NSIndexPath *selectedRowIndexPath = [self.productsTableView indexPathForSelectedRow];
//    detailViewController.product = [self.listOfProducts objectAtIndex:selectedRowIndexPath.row];
}


@end
