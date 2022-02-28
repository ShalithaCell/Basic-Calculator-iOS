//
//  ViewController.m
//  Calculator
//
//  Created by Shalitha Senanayaka on 2019-04-11.
//  Copyright © 2019 Shalitha Senanayaka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //initialize
    self.lblExpression.text = @"";
    self.lblResult.text = @"= ";
    
    
}


// all action buttons pressed
- (IBAction)btnAction:(UIButton *)sender {
    
    //check if Expression is exists
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    NSString *mul = @"x";
    NSString *div = @"/";
    
    //check action is multiply or divition
    if([sender.titleLabel.text isEqualToString:mul] || [sender.titleLabel.text  isEqualToString:div]){
        
        //add parenthesis
        NSString *expression = [NSString stringWithFormat:@"(%@)%@",self.lblExpression.text,sender.titleLabel.text];
        
        self.lblExpression.text = expression;
        
    }
    else{
        NSString *expression = [NSString stringWithFormat:@"%@%@",self.lblExpression.text,sender.titleLabel.text];
        
        self.lblExpression.text = expression;
    }
    
    //initialize result
    self.lblResult.text = @"= ";
    
}

//Eqal button pressed
- (IBAction)btnEqal:(UIButton *)sender {
    
    //check if expression is exists
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    @try {
        NSString *rawInputString = [NSString stringWithFormat:@"%@", self.lblExpression.text];
        NSString *numericExpression = @"";
        if ([rawInputString containsString:@"."])  {
            numericExpression = rawInputString;
        } else {
            //add one decimal point to last number to get result as recimal points
            numericExpression = [NSString stringWithFormat:@"%@.0", self.lblExpression.text];
        }
        
        //replace '*' instead of 'x'
        numericExpression = [numericExpression stringByReplacingOccurrencesOfString:@"x"
                                       withString:@"*"];
        
        NSExpression *expression = [NSExpression expressionWithFormat:numericExpression];
        
        
        NSNumber *result = [expression expressionValueWithObject:nil context:nil];
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@", result]);
        
        self.lblResult.text = [NSString stringWithFormat:@"= %@", result];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        
        [self displayAlert];
        
    } @finally {
       
    }
    
   
}

- (IBAction)btnClear:(UIButton *)sender {
    
    //check if expression is exists
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    NSString *numericExpression = self.lblExpression.text;
    
    //get last character
    NSString *lastChar = [numericExpression substringFromIndex:[numericExpression length] - 1];
    
    //check the char is '0)'
    if([lastChar isEqualToString:@")"]){
        
        //then delete '(' and ')'
        
        NSString *Prefix = @"(";
        NSString *Suffix = @")";
        NSRange needleRange = NSMakeRange(Prefix.length,
                                          numericExpression.length - Prefix.length - Suffix.length);
        numericExpression = [numericExpression substringWithRange:needleRange];
        
        
    }else{
        //remove last character
        numericExpression = [numericExpression substringToIndex:[numericExpression length]-1];
    }
    
    //update
    self.lblExpression.text = numericExpression;
    self.lblResult.text = @"= ";
}

- (IBAction)btnReset:(UIButton *)sender {
    self.lblResult.text = @"= ";
    self.lblExpression.text = @"";
}

- (IBAction)btnNumberClick:(UIButton *)sender {
    
    if(self.lblExpression.text.length != 0){
        NSString *lastChar = [self.lblExpression.text substringFromIndex:[self.lblExpression.text length] - 1];
        
        if([lastChar isEqualToString:@"."] && [sender.titleLabel.text isEqualToString:@"."]){
            return;
        }
    }
    
    //check if enterd double dot
    
    
    
    NSString *expression = [NSString stringWithFormat:@"%@%@",self.lblExpression.text,sender.titleLabel.text];
    
    self.lblExpression.text = expression;
    self.lblResult.text = @"= ";
    
}

-(void) displayAlert{
    NSString *title = @"Alert";
    NSString *message = @"Incorrect Expression";
    NSString *okButtonText = @"ok";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:okButtonText style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
