//
//  CourseViewTable.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "CourseViewTable.h"
#import "ViewController.h"
#import "StudentListTable.h"

@interface CourseViewTable()

@property (strong, nonatomic) IBOutlet UITableView *courseTableView;
@property (strong, nonatomic) CourseDBManager * crsDB;



@property (strong, nonatomic) NSMutableArray * courseList;

@end

@implementation CourseViewTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.courseTableView.dataSource = self;
    self.navigationItem.title = @"Courses";
    self.crsDB = [[CourseDBManager alloc] initDatabaseName:@"coursedb"];
    
    
    
    
    
    
  /*
    self.courseTableView.dataSource = self;
    
    self.courseList = [[NSMutableArray alloc] init];
    
   
    
    [self.courseList addObject:@"Course 1"];
    [self.courseList addObject:@"Course 2"];
    [self.courseList addObject:@"Course 3"];
    NSLog(@"No of rows %lu",[self.courseList count] );
    [self.courseTableView reloadData];
    
    */
    
    
    
    /*
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_courseDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if (sqlite3_exec(_courseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_courseDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
    
    */
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.courseTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
   // return [self.courseList count];
  //  NSLog([NSString stringWithFormat:@"No of rows %f",[self.courseList count] ]);
    //   return [[self.wpLib allKeys] count];
    
    NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
    return queryRes.count;
    
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
    NSString * ret = @"unknown";
    
    if(queryRes.count> indexPath.row){
        ret = queryRes[indexPath.row][0];
    }
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSArray *keys = self.courseList;
    //  NSLog(@"Keys: %@",keys);
    
  
    
    cell.textLabel.text = ret;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // Configure the cell...
    
    return cell;
}

*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
    NSString * whichCrs = @"unknown";
    if(queryRes.count> indexPath.row){
        whichCrs = queryRes[indexPath.row][0];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = whichCrs;
    return cell;
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"CourseToStudent"]){
        NSIndexPath * indexPath = [self.courseTableView indexPathForSelectedRow];
        // NSArray * keys = [self.wpLib allKeys];
        
       /* NSArray * keys = self.courseList;
        NSString * ret  =@"Unknown";
        if(indexPath.row < keys.count){
            ret = keys[indexPath.row];
        }
        
        ViewController * destViewController = segue.destinationViewController;
        
        */
     //   destViewController.waypointName = ret;
    //    destViewController.wpLib = self.wpLib;
     //   destViewController.wpList = self.waypointList;
        
        
        
        NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
        NSString * whichCrs = @"unknown";
        if(queryRes.count> indexPath.row){
            whichCrs = queryRes[indexPath.row][0];
        }
        StudentListTable *destViewController = segue.destinationViewController;
        NSLog(@"prepareForSeque setting course to %@",whichCrs);
        destViewController.parent = self;
        destViewController.selectedCourse = whichCrs;
        
        
        
        
    }
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
