//
//  UCSFViewController.m
//  ProteinCounts
//
//  Created by Pankaj Gupta on 3/29/14.
//  Copyright (c) 2014 UCSF. All rights reserved.
//

#import "UCSFViewController.h"

@interface UCSFViewController ()

@end

@implementation UCSFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _goBtn.layer.cornerRadius = 4;
	// Do any additional setup after loading the view, typically from a nib.
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
    handler(@[@"rbn", @"rbp", @"some", @"here", @"rbx"]);
}


@end
