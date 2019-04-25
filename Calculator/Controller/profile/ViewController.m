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
    
    self.lblExpression.text = @"";
    
    self.lblResult.text = @"= ";
    
    /*NSString *numericExpression = @"(5 + 5) * 2 / 2";
    NSExpression *expression = [NSExpression expressionWithFormat:numericExpression];
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@", result]);*/
}



- (IBAction)btnAction:(UIButton *)sender {
    
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    NSString *mul = @"x";
    NSString *div = @"/";
    
    if([sender.titleLabel.text isEqualToString:mul] || [sender.titleLabel.text  isEqualToString:div]){
        
        NSString *expression = [NSString stringWithFormat:@"(%@)%@",self.lblExpression.text,sender.titleLabel.text];
        
        self.lblExpression.text = expression;
        
    }
    else{
        NSString *expression = [NSString stringWithFormat:@"%@%@",self.lblExpression.text,sender.titleLabel.text];
        
        self.lblExpression.text = expression;
    }
    
    self.lblResult.text = @"= ";
    
}

- (IBAction)btnEqal:(UIButton *)sender {
    
    //check if expression is exists
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    @try {
        NSString *numericExpression = [NSString stringWithFormat:@"%@.0", self.lblExpression.text];
        
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
    
    if(self.lblExpression.text.length == 0){
        return;
    }
    
    NSString *numericExpression = self.lblExpression.text;
    
    NSString *lastChar = [numericExpression substringFromIndex:[numericExpression length] - 1];
    
    if([lastChar isEqualToString:@")"]){
        numericExpression = [numericExpression substringToIndex:[numericExpression length]-1];
        
        numericExpression = [numericExpression substringToIndex:0];
    }else{
        numericExpression = [numericExpression substringToIndex:[numericExpression length]-1];
    }
    
    self.lblExpression.text = numericExpression;
    self.lblResult.text = @"= ";
}

- (IBAction)btnReset:(UIButton *)sender {
    self.lblResult.text = @"= ";
    self.lblExpression.text = @"";
}

- (IBAction)btnNumberClick:(UIButton *)sender {
    
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
