//
//  QPLViewController.m
//  CrashMonitor
//
//  Created by lidian6864677 on 12/13/2019.
//  Copyright (c) 2019 lidian6864677. All rights reserved.
//

#import "QPLViewController.h"
#import "NSObjectTest.h"
@interface QPLViewController ()

@end

@implementation QPLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSObjectTest *obj = [NSObjectTest new];
        [obj test];
    
    NSArray *arr = [[NSArray alloc]init];
//    arr[2];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
