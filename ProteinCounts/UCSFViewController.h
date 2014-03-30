//
//  UCSFViewController.h
//  ProteinCounts
//
//  Created by Pankaj Gupta on 3/29/14.
//  Copyright (c) 2014 UCSF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextFieldDataSource.h"


@interface UCSFViewController : UIViewController <MLPAutoCompleteTextFieldDataSource>
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@end
