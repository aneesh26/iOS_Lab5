//
//  StudentDetails.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "StudentDetails.h"


@implementation StudentDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Student Details";
    
    UIBarButtonItem *btnDel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delClicked:)];
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClicked:)];
    
    
    self.navigationItem.rightBarButtonItems = @[btnSave,btnDel];
}

@end
