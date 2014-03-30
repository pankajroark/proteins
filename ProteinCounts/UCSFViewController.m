//
//  UCSFViewController.m
//  ProteinCounts
//
//  Created by Pankaj Gupta on 3/29/14.
//  Copyright (c) 2014 UCSF. All rights reserved.
//

#import "UCSFViewController.h"

@interface UCSFViewController ()
- (void) loadData;
@end

@implementation UCSFViewController

NSMutableDictionary* dict;
NSString *content;
NSMutableArray* rows;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _goBtn.layer.cornerRadius = 4;
	// Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    self.history.dataSource = self;
    self.history.delegate = self;
    rows = [[NSMutableArray alloc] init];
}

- (void) loadData
{
    NSLog(@"load data called");
    NSString* csvPath = [[NSBundle mainBundle] pathForResource:@"protein_synthesis_rate" ofType:@"csv"];
    NSLog(@"csv path %@", csvPath);
    content = [NSString stringWithContentsOfFile:csvPath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSLog(@"%@", content);
    dict = [[NSMutableDictionary alloc] init];
    NSArray* allLinedStrings =
    [content componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    for (NSString* line in allLinedStrings) {
        NSArray* parts =
        [line componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        [dict setValue:parts forKey:[parts objectAtIndex:0]];
    }
    NSLog(@"Dictionary %@", dict);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    NSArray* proteins = [dict allKeys];
    NSMutableArray* filtered = [[NSMutableArray alloc] init];
    for(NSString* protein in proteins) {
        if([protein hasPrefix:string]) {
            [filtered addObject:protein];
        }
    }
    handler(filtered);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int row = [indexPath row];
    NSLog(@"rows count: %d", [rows count]);
    NSLog(@"row: %d", row);
    if([rows count] > row) {
        NSArray* rowData = [rows objectAtIndex: [rows count] - row - 1];
        NSString* proteinName = [rowData objectAtIndex: 0];
        NSString* count = [rowData objectAtIndex: 1];
        NSString* rowText = [NSString stringWithFormat:@"%@ - %@", proteinName, count];
        NSLog(@"row text: %@", rowText);
        cell.textLabel.text = rowText;
    }
    return cell;
}


- (IBAction)onGo:(id)sender {
    NSLog(@"on go called");
    NSString* searchText = [self.searchBox text];
    NSLog(@"search text : %@", searchText);
    NSArray* row = [dict objectForKey: searchText];
    [self updateHistory:row];
}

- (void) updateHistory: (NSArray*) row
{
    NSLog(@"row : %@", row);
    NSMutableArray* newRows = [[NSMutableArray alloc] init];
    for( NSArray* existingRow in rows)
    {
        if(![row isEqualToArray: existingRow]) {
            [newRows addObject:existingRow];
        }
    }
    [newRows addObject: row];
    rows = newRows;
    NSLog(@"go rows count: %d", [rows count]);
    [self.history reloadData];
}
@end
