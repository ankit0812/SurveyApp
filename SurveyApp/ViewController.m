//
//  ViewController.m
//  SurveyApp
//
//  Created by optimusmac4 on 8/6/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIView.h>
#import <CoreData/CoreData.h>


@interface ViewController ()
{
    NSArray *color;
}

@end

@implementation ViewController

static NSString *colorFromPickr;

static int k=0,img1=0,img2=0,img3=0,img4=0;


/*Use this block if we want Core Data
- (NSManagedObjectContext *)managedObjectContext {          //This allows us to get the managed object context from the AppDelegate
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //setting delegates manually for dismissing keyboard when return is pressed
    
    self.manufacturer.delegate=self;
    self.model.delegate=self;
    self.serialNumber.delegate=self;
    self.colorInfo.delegate=self;
    self.sizeInfo.delegate=self;
    self.emailID.delegate=self;
    
    
    // Tap Guesture Recognition for images
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.scroller addGestureRecognizer:yourTap];
    [self.view addSubview:_scroller];
    [self.scroller setScrollEnabled:YES];
    
    
    _image1.image=[UIImage imageNamed:@"neon.jpg"];
    _image2.image=[UIImage imageNamed:@"information.jpg"];
    _image3.image=[UIImage imageNamed:@"internet.jpg"];
    _image4.image=[UIImage imageNamed:@"candy.jpg"];
    
    
    //Initializing the PickController elements
    color=[[NSArray alloc] initWithObjects:@"Red",@"Blue",@"Green", nil];
    
    // For Keyboard and TextField Adjustment
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected1)];
    singleTap1.numberOfTapsRequired = 1;
    _image1.userInteractionEnabled = YES;
    [_image1 addGestureRecognizer:singleTap1];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected2)];
    singleTap2.numberOfTapsRequired = 1;
    _image2.userInteractionEnabled = YES;
    [_image2 addGestureRecognizer:singleTap2];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected3)];
    singleTap3.numberOfTapsRequired = 1;
    _image3.userInteractionEnabled = YES;
    [_image3 addGestureRecognizer:singleTap3];
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected4)];
    singleTap4.numberOfTapsRequired = 1;
    _image4.userInteractionEnabled = YES;
    [_image4 addGestureRecognizer:singleTap4];
    
}

-(void)viewDidUnload
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - Initializing and populating the PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return color.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [color objectAtIndex:row];
}


// The Submit Button Performs and Co-ordinates all the actions of the App

- (IBAction)submit:(id)sender {
    	
    UIAlertView *message;
    
            /* if we need to use core data we can use this module
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *survey = [NSEntityDescription insertNewObjectForEntityForName:@"Survey" inManagedObjectContext:context]; // create a new managedd object to take the input -- Employee Here referes to the entity name
    
    
    //taking input from textfields to set the attributes

            */
    
    //If question 1 is not answered
    if([colorFromPickr isEqual:@""] || k<1){
        message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                         message:@"Favorite Color Not Selected"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        
        [message show];
        
    //If question 2 is not answered
    } else if(img1==0 && img2==0 && img3==0 && img4==0){
        
        message = [[UIAlertView alloc] initWithTitle:@"Message"
                                             message:@"Not Selected Image for How did \n your hear from us"
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        
        [message show];
        
    //If question 3 is not answered
    } else if(([_manufacturer.text isEqual:@""]) || ([_model.text isEqual:@""]) || ([_serialNumber.text isEqual:@""]) || ([_colorInfo isEqual:@""]) || ([_sizeInfo.text isEqual:@""])){
        
        message = [[UIAlertView alloc] initWithTitle:@"Message"
                                             message:@"Complete Product Info Not Available"
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        
        [message show];
        
    //If question 6 is not answered
    } else if(![self NSStringIsValidEmail:_emailID.text]){
        
        message = [[UIAlertView alloc] initWithTitle:@"Message"
                                             message:@"Email ID Invalid"
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        
        [message show];
        
    // If all runs fine i.e all questions are answered
    } else {
        
        // For Date
        NSDate *myDate = _dateSelecter.date;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"cccc, MMM d"];
        NSString *finalDate = [dateFormat stringFromDate:myDate];
        
        NSLog(@"%@",finalDate);
        
        //  For the Time
        NSDate *time = _timeSelecter.date;
        
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@" hh:mm aa"];
        NSString *finalTime = [timeFormat stringFromDate:time];
        
        NSLog(@"Time %@",finalTime);

        
        // Writing to file myFile

        [self writeStringToFile:[NSString stringWithFormat:@"Survey ID : %@ \n",finalTime]];
        [self writeStringToFile:[NSString stringWithFormat:@"Question 1 : Ans 1 : %@ \n",colorFromPickr]];
       // [self writeStringToFile:[NSString stringWithFormat:@"Question 2 : Ans 1 : %@ \n",finalTime]];
        [self writeStringToFile:[NSString stringWithFormat:@"Question 3 : Ans 1 : %@ : Ans 2 : %@ : Ans 3 : %@ : Ans 4 : %@ : Ans 5 : %@\n",_manufacturer,_model,_serialNumber,_colorInfo,_sizeInfo]];
        [self writeStringToFile:[NSString stringWithFormat:@"Question 4 : Ans 1 : %@ \n",finalDate]];
        [self writeStringToFile:[NSString stringWithFormat:@"Question 5 : Ans 1 : %@ \n",finalTime]];
        [self writeStringToFile:[NSString stringWithFormat:@"Question 6 : Ans 1 : %@ \n",_emailID]];
        [self writeStringToFile:[NSString stringWithFormat:@" --------------- \n\n"]];
        
        
        message = [[UIAlertView alloc] initWithTitle:@"Message"
                                             message:@"Congratulations "
                                            delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        
        [message show];

                    /* We can use this module if we want to use core data instead of file "
        [survey setValue:finalTime forKey:@"idNo"];
        [survey setValue:@"1" forKey:@"questionNo1"];
        [survey setValue:colorFromPickr forKey:@"answerNo1"];
        
        [survey setValue:@"2" forKey:@"questionNo2"];
        [survey setValue:@"1" forKey:@"answerNo2"];
        
        [survey setValue:@"3" forKey:@"questionNo3"];
        [survey setValue:_manufacturer.text forKey:@"answer31"];
        [survey setValue:_model.text forKey:@"answerNo32"];
        [survey setValue:_serialNumber.text forKey:@"answerNo33"];
        [survey setValue:_colorInfo.text forKey:@"answerNo34"];
        [survey setValue:_sizeInfo.text forKey:@"answerNo35"];

        
        [survey setValue:@"4" forKey:@"questionNo4"];
        [survey setValue:finalDate forKey:@"answerNo4"];
        
        [survey setValue:@"5" forKey:@"questionNo5"];
        [survey setValue:finalTime forKey:@"answerNo5"];
        
        [survey setValue:@"6" forKey:@"questionNo6"];
        [survey setValue:_emailID forKey:@"answerNo6"];
     
                    */
    }
    
}

// Color Selection

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    colorFromPickr=[NSString stringWithFormat:@"%@",[color objectAtIndex:[_picker1 selectedRowInComponent:0]]];
    
    NSLog(@"%@",colorFromPickr);
    k++;
    
}

//make keyboard disappear , you can use resignFirstResponder too, it's depend.

- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer{
    
    [self.view endEditing:YES];
}

// Dismiss keyboard on return

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}


//email id validation
-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

// Function to write data to file named myTextFile.txt

- (void)writeStringToFile:(NSString*)aString {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString* fileName = @"myTextFile.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSLog(@"Directory where the file is created %@",fileAtPath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}


#pragma - Deals with adjusting the keyboard with the screen show that if a text box is selected keyboard moves down

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    CGPoint scrollPoint;
    
    
    // for various text fields
    if (!CGRectContainsPoint(aRect, _emailID.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _emailID.frame.origin.y - (keyboardSize.height-15));
    }
    else if (!CGRectContainsPoint(aRect, _manufacturer.frame.origin))
    {
       
       scrollPoint = CGPointMake(0.0, _manufacturer.frame.origin.y - (keyboardSize.height-15));
    }
    else if ( !CGRectContainsPoint(aRect, _model.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _model.frame.origin.y - (keyboardSize.height-15));
    }
    else if (  !CGRectContainsPoint(aRect, _sizeInfo.frame.origin))
    {
      
      scrollPoint = CGPointMake(0.0, _sizeInfo.frame.origin.y - (keyboardSize.height-15));
    }
    else if (!CGRectContainsPoint(aRect, _colorInfo.frame.origin))
    {
       
       scrollPoint = CGPointMake(0.0, _colorInfo.frame.origin.y - (keyboardSize.height-15));
    }
    else if (!CGRectContainsPoint(aRect, _serialNumber.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _serialNumber.frame.origin.y - (keyboardSize.height-15));
    }
    
    [_scroller setContentOffset:scrollPoint animated:YES];
        
   
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _emailID = textField;
    _manufacturer = textField;
    _model= textField;
    _sizeInfo = textField;
    _colorInfo = textField;
    _serialNumber = textField;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _emailID = nil;
    _manufacturer = nil;
    _model= nil;
    _sizeInfo = nil;
    _colorInfo = nil;
    _serialNumber = nil;
}



#pragma - To Check which Image is being tapped on
// Check the image which is tapped on

-(void)tapDetected1{
    img1=1;
    _image1.hidden=YES;
    img2=img3=img4=0;
    _image2.hidden=_image3.hidden=_image4.hidden=NO;
    NSLog(@"Image 1");
    
}
-(void)tapDetected2{
    img2=1;
    _image2.hidden=YES;
    img1=img3=img4=0;
    _image1.hidden=_image3.hidden=_image4.hidden=NO;
    NSLog(@"Image 2");
}
-(void)tapDetected3{
    img3=1;
    _image3.hidden=YES;
    img2=img1=img4=0;
    _image2.hidden=_image1.hidden=_image4.hidden=NO;
    NSLog(@"Image 3");
    
}
-(void)tapDetected4{
    img4=1;
    _image4.hidden=YES;
    img2=img3=img1=0;
    _image2.hidden=_image3.hidden=_image1.hidden=NO;
    NSLog(@"Image 4");
    
}

@end
