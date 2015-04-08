//
//  CourseViewTable.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "CourseViewTable.h"
#import "ViewController.h"

@interface CourseViewTable()

@property (strong, nonatomic) IBOutlet UITableView *courseTableView;




@property (strong, nonatomic) NSMutableArray * courseList;

@end

@implementation CourseViewTable

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.courseTableView.dataSource = self;
    
    self.courseList = [[NSMutableArray alloc] init];
    
   
    
    [self.courseList addObject:@"Course 1"];
    [self.courseList addObject:@"Course 2"];
    [self.courseList addObject:@"Course 3"];
    NSLog(@"No of rows %lu",[self.courseList count] );
    [self.courseTableView reloadData];
    
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
    
    return [self.courseList count];
  //  NSLog([NSString stringWithFormat:@"No of rows %f",[self.courseList count] ]);
    //   return [[self.wpLib allKeys] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSArray *keys = self.courseList;
    //  NSLog(@"Keys: %@",keys);
    
    NSString * ret = @"unknown";
    
    if(indexPath.row < keys.count){
        ret = keys[indexPath.row];
    }
    
    cell.textLabel.text = ret;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // Configure the cell...
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"CourseToStudent"]){
        NSIndexPath * indexPath = [self.courseTableView indexPathForSelectedRow];
        // NSArray * keys = [self.wpLib allKeys];
        
        NSArray * keys = self.courseList;
        NSString * ret  =@"Unknown";
        if(indexPath.row < keys.count){
            ret = keys[indexPath.row];
        }
        
        ViewController * destViewController = segue.destinationViewController;
     //   destViewController.waypointName = ret;
    //    destViewController.wpLib = self.wpLib;
     //   destViewController.wpList = self.waypointList;
    }
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
