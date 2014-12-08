//
//  MenuCardViewController.m
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import "MenuCardViewController.h"
#import "Tisch.h"

@interface MenuCardViewController ()

@end

@implementation MenuCardViewController

#define SimplePaySeviceURL [NSURL URLWithString: @"http://54.173.138.214/api/Produkt"]

@synthesize listOfProducts;

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
    return [listOfProducts count];
}

//TableView füllen
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Tisch *t = [self.listOfProducts objectAtIndex:indexPath.row];
    
    NSString *bezeichnung = t.bezeichnung;
    NSString *eingetragen_am = t.eingetragen_am;
    
    
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
            
            Tisch *t = [[Tisch alloc] init];
            
            NSInteger t_id = [[dict objectForKey:@"t_id"]integerValue];
            NSString *bezeichnung = [dict objectForKey:@"bezeichnung"];
            NSString *eingetragen_am = [dict objectForKey:@"eingetragen_am"];

            t.t_id = t_id;
            t.bezeichnung = bezeichnung;
            t.eingetragen_am = eingetragen_am;

            
            [listOfProducts addObject:t];
            
        }
        
    }
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
