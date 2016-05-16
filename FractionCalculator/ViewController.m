//
//  ViewController.m
//  FractionCalculator
//
//  Created by MF839-002 on 2016. 5. 16..
//  Copyright © 2016년 MF839-002. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char op;
    int currentNumber;
    BOOL firstOperand, isNumberator;
    Calculator *myCalculator;
    NSMutableString *displayString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    firstOperand = YES;
    isNumberator = YES;
    displayString = [NSMutableString stringWithCapacity:40];
    myCalculator = [[Calculator alloc]init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickDigit:(id)sender{
    int digit = (int)[sender tag];
    [self processDigit: digit];
}

- (IBAction)clickOver:(id)sender {
    [self storeFracPart];
    isNumberator = NO;
    [displayString appendString: @"/"];
    _display.text = displayString;
}

- (IBAction)clickClear:(id)sender {
    isNumberator = YES;
    firstOperand = YES;
    currentNumber = 0;
    [myCalculator clear];
    
    [displayString setString:@""];
    _display.text = displayString;
}

- (IBAction)clickEqual:(id)sender {
    if(firstOperand == NO) {
        [self storeFracPart];
        [myCalculator performOperation: op];
        
        [displayString appendString:@" = "];
        [displayString appendString : [myCalculator.accumulator convertToString]];
        
        _display.text = displayString;
        
        currentNumber = 0;
        isNumberator = YES;
        firstOperand = YES;
        [displayString setString: @""];
    }
}

- (IBAction)clickMinus:(id)sender {
    [self processOp: '-'];
}

- (IBAction)clickPlus:(id)sender {
    [self processOp: '+'];
}

- (IBAction)clickMultiply:(id)sender {
    [self processOp: '*'];
}

- (IBAction)clickDivide:(id)sender {
    [self processOp: '/'];
}

- (void)processDigit:(int)digit{
    currentNumber = currentNumber * 10 + digit;
    
    [displayString appendString: [NSString stringWithFormat:@"%i", digit]];
    _display.text = displayString;
}

- (void)processOp:(char)theOp{
    NSString *opStr;
    
    op = theOp;
    
    switch (theOp){
        case '+':
            opStr = @" + ";
            break;
        case '-':
            opStr = @" - ";
            break;
        case '*':
            opStr = @" * ";
            break;
        case '/':
            opStr = @" / ";
            break;
        default:
            break;
    }
    [self storeFracPart];
    firstOperand = NO;
    isNumberator = YES;
    [displayString appendString:opStr];
    _display.text = displayString;
}

- (void)storeFracPart{
    if(firstOperand){
        if(isNumberator) {
            myCalculator.operand1.numerator = currentNumber;
            myCalculator.operand1.denominator = 1;
        }
        else
            myCalculator.operand1.denominator = currentNumber;
    }
    else if(isNumberator){
        myCalculator.operand2.numerator = currentNumber;
        myCalculator.operand2.denominator = 1;
    }
    else{
        myCalculator.operand2.denominator = currentNumber;
        firstOperand = YES;
    }
    
    currentNumber = 0;
    
}
@end
