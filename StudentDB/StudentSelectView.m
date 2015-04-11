//
//  studentSelectView.m
//  StudentDB
//
//  Created by ashastry on 4/11/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "StudentSelectView.h"


@interface StudentSelectView()

@property (weak, nonatomic) IBOutlet UILabel *courseNameTF;
@property (weak, nonatomic) IBOutlet UITextField *studentNameTF;
@property (strong, nonatomic) IBOutlet UIPickerView *studentPicker;

@end

@implementation StudentSelectView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.courseNameTF setText:self.selectedCourse];
    self.studentPicker = [[UIPickerView alloc] init];
    self.studentPicker.delegate = self;
    self.studentPicker.dataSource = self;
    
    self.studentNameTF.inputView = self.studentPicker;
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked:)];
    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClicked:)];
    
    self.navigationItem.leftBarButtonItem = btnCancel;
    
    self.navigationItem.rightBarButtonItem = btnSave;
    
    
    NSString* queryString = [[@"select distinct name from student,studenttakes,course where course.coursename = '"
                              stringByAppendingString: self.selectedCourse]
                             stringByAppendingString:@"' and course.courseid != studenttakes.courseid and student.studentid = studenttakes.studentid;"];
    NSLog(queryString);
    
    
    NSMutableArray * queryRes =  [self.crsDB executeQuery:queryString];
    
    
    //get list of students whiohc donot match course id with selected course
    //get list of students who are not in the student takes table
    //filter list of students with the ones which are already in the current course and also in other course
    
    self.studentList = [[NSMutableArray alloc] init];
    
    for(NSArray* studentIDObject in queryRes){
       NSString* student = studentIDObject[0];
        [self.studentList addObject:student];
    }
    
    //NSArray * studentIDObject = queryRes[0];
 //   NSLog(studentIDObject[0]);
  //  NSString* student = studentIDObject[0];
    
   // [self.studentList addObject:student];
 //   for(NSArray* result in studentIDObject){
   //     [self.studentList addObject:result[0]];
    //     }
  // NSString * studentID = studentIDObject[3];
    
    //self.studentList = studentIDObject;

    
    
}

-(void)saveClicked:(id)sender{
    
    
    
    
    
       [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)cancelClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSArray * keys = self.studentList;
    if(row < keys.count){
        
        
        if(pickerView == self.studentPicker){
            [self.studentPicker resignFirstResponder];
           
            [self.studentNameTF setText:keys[row]];
            
        }
    }
    
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
    NSArray * keys = self.studentList;
    
    
    NSString * returnString = @"Unknown Key";
    if(row < keys.count){
        returnString = keys[row];
    }
    //NSLog(@"%@",returnString);
    return returnString;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.studentList count];
}



@end
