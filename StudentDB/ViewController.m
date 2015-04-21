/**
 * Copyright 2015 Aneesh Shastry,
 * <p/>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p/>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p/>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * <p/>
 * Purpose: An iOS application for Student Course Database to Add/Remove Course, Add/Remove Student and Enroll/Drop students from courses using SQLite. Select Student Name and Email address from address book
 *
 * @author Aneesh Shastry ashastry@asu.edu
 *         MS Computer Science, CIDSE, IAFSE, Arizona State University
 * @version April 20, 2015
 */


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
