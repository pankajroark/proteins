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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _goBtn.layer.cornerRadius = 4;
	// Do any additional setup after loading the view, typically from a nib.
    [self loadData];
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


@end
