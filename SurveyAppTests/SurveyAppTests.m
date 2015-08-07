//
//  SurveyAppTests.m
//  SurveyAppTests
//
//  Created by optimusmac4 on 8/6/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface ViewController (Test)

    -(BOOL) NSStringIsValidEmail:(NSString *)checkString;
    - (void)writeStringToFile:(NSString*)aString;

@end

@interface SurveyAppTests : XCTestCase

@property (nonatomic) ViewController *viewController;

@end


@implementation SurveyAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewController=[[ViewController alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    
    BOOL a=[self.viewController.manufacturer.text isEqual:@""];
    XCTAssertEqual(YES,a);
    
    
    BOOL b=[self.viewController.manufacturer.text isEqual:@"Ankit"];
    XCTAssertEqual(YES,b);
}

- (void)testPickerControllerInitialCapacity {
    
    NSInteger i=[self.viewController numberOfComponentsInPickerView:self.viewController.picker1];
    XCTAssertEqual(i,1);
}

- (void)testDate{
    
    NSDate *myDate = self.viewController.dateSelecter.date;
    NSLog(@"%@",myDate);
    BOOL a=[self.viewController NSStringIsValidEmail:@"ankitkumargupta@gmail.com"];
    NSLog(@"helloooo its a %hhd",a);
    
    XCTAssertFalse(NO,@"%hhd",a);
    
}

- (void)testPerformance1 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        [self.viewController numberOfComponentsInPickerView:self.viewController.picker1];    }];
}


- (void)testPerformance2 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSInteger i=10;
        
[self.viewController pickerView:self.viewController.picker1 numberOfRowsInComponent:i];
    }];
}


- (void)testPerformance3 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSInteger i=10;
        NSInteger j=20;
        
        
    [self.viewController pickerView:self.viewController.picker1 titleForRow:i forComponent:j];
       }];
}
- (void)testPerformance4 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.viewController writeStringToFile:@"Survey Reached Here"];
    }];
}


@end
