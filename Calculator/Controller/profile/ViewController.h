//
//  ViewController.h
//  Calculator
//
//  Created by Shalitha Senanayaka on 2019-04-11.
//  Copyright © 2019 Shalitha Senanayaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *lblExpression;
@property (strong, nonatomic) IBOutlet UILabel *lblResult;

- (IBAction)btnAction:(UIButton *)sender;


- (IBAction)btnEqal:(UIButton *)sender;


- (IBAction)btnClear:(UIButton *)sender;

- (IBAction)btnReset:(UIButton *)sender;

- (IBAction)btnNumberClick:(UIButton *)sender;


@end

