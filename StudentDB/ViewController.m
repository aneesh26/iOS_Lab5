//
//  ViewController.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self testQuery];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) testQuery {
    // log the documents directory for this app
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    CourseDBManager * cdbm = [[CourseDBManager alloc] initDatabaseName:@"coursedb"];
    NSArray * queryRes = [cdbm executeQuery:@"select name, major from student;"];
    for (int i = 0; i<queryRes.count; i++){
        NSArray * row = queryRes[i];
        for (int j =0; j<row.count; j++){
            NSLog(@"row: %d col %d %@ is: %@",i, j, cdbm.arrColNames[j] ,row[j]);
        }
    }
}




@end
