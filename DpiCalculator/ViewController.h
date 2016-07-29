//
//  ViewController.h
//  DpiCalculator
//
//  Created by 7heaven on 16/7/13.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutputDpiView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet OutputDpiView *ldpiOutputView;
@property (weak) IBOutlet OutputDpiView *mdpiOutputView;
@property (weak) IBOutlet OutputDpiView *hdpiOutputView;
@property (weak) IBOutlet OutputDpiView *xhdpiOutputView;
@property (weak) IBOutlet OutputDpiView *xxhdpiOutputView;
@property (weak) IBOutlet OutputDpiView *xxxhdpiOutputView;

@property (weak) IBOutlet NSTextField *widthInput;
@property (weak) IBOutlet NSTextField *heightInput;
@property (weak) IBOutlet NSComboBox *dpiInputSelector;
@property (weak) IBOutlet NSButton *calculateButton;
@property (weak) IBOutlet NSButton *lockResolutionButton;

@property (strong, nonatomic) NSStatusItem *statusBarItem;
- (IBAction)calculateButtonClick:(id)sender;
- (IBAction)lockResolutionButtonClick:(id)sender;
@end

