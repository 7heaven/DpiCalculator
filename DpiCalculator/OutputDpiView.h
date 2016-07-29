//
//  OutputDpiView.h
//  DpiCalculator
//
//  Created by 7heaven on 16/7/13.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OutputDpiView : NSView

@property (strong, nonatomic) NSTextField *title;
@property (strong, nonatomic) NSTextField *widthLabel;
@property (strong, nonatomic) NSTextField *heightLabel;

@property (strong, nonatomic) NSButton *widthOutput;
@property (strong, nonatomic) NSButton *heightOutput;

@end
