//
//  ViewController.m
//  DpiCalculator
//
//  Created by 7heaven on 16/7/13.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import "ViewController.h"
#import "ScrollingLayer.h"
#import "ScrollView.h"
#import "OnlyIntegerValueFormatter.h"

typedef struct Resolution{
    int width;
    int height;
}Resolution;

typedef NS_ENUM(int, DpiDef){
    DpiDefLDpi = 0,
    DpiDefMDpi = 1,
    DpiDefHDpi = 2,
    DpiDefXhDpi = 3,
    DpiDefXxhDpi = 4,
    DpiDefXxxhDpi = 5
};

static inline Resolution ResolutionMake(int width, int height){
    return (Resolution){width, height};
}

static inline NSValue * resolutionValue(int width, int height){
    Resolution resolution = ResolutionMake(width, height);
    
    NSValue *resolutionValue = [NSValue value:&resolution withObjCType:@encode(Resolution)];
    
    return resolutionValue;
}

static inline Resolution getResolutionFromValue(NSValue *value){
    Resolution resolution;
    [value getValue:&resolution];
    
    return resolution;
}

@interface ViewController() <NSComboBoxDataSource, NSTextFieldDelegate, NSComboBoxDelegate>
@end

@implementation ViewController{
    NSArray *_dpiViews;
    NSArray *_dpiTitles;
    NSArray *_dpiDensities;
    NSArray *_dpiResolutions;
    
    BOOL _resolutionInputLocked;
    NSUInteger _currentComboBoxSelection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setResolutionLocked:NO];

    _dpiViews = @[
                  self.ldpiOutputView,
                  self.mdpiOutputView,
                  self.hdpiOutputView,
                  self.xhdpiOutputView,
                  self.xxhdpiOutputView,
                  self.xxxhdpiOutputView
                  ];
    
    _dpiTitles = @[
                   @"ldpi",
                   @"mdpi",
                   @"hdpi",
                   @"xhdpi",
                   @"xxhdpi",
                   @"xxxhdpi"
                   ];
    
    _dpiDensities = @[
                      @(0.75F),
                      @(1.0F),
                      @(1.5F),
                      @(2.0F),
                      @(3.0F),
                      @(4.0F)
                      ];
    
    _dpiResolutions = @[
                        @(120),
                        @(160),
                        @(240),
                        @(320),
                        @(480),
                        @(640)
                        ];
    
    for(int i = 0; i < _dpiViews.count; i++){
        OutputDpiView *outputView = _dpiViews[i];
        
        [outputView.widthOutput setTarget:self];
        [outputView.heightOutput setTarget:self];
        [outputView.widthOutput setAction:@selector(outputClick:)];
        [outputView.heightOutput setAction:@selector(outputClick:)];
        
        [outputView.title setStringValue:_dpiTitles[i]];
    }
    
    self.dpiInputSelector.usesDataSource = YES;
    self.dpiInputSelector.dataSource = self;
    self.dpiInputSelector.delegate = self;
    
    _currentComboBoxSelection = 3;
    
    [self.dpiInputSelector selectItemAtIndex:_currentComboBoxSelection];
    self.dpiInputSelector.numberOfVisibleItems = _dpiTitles.count;
    
    self.widthInput.delegate = self;
    self.heightInput.delegate = self;
    
    [self.widthInput setFormatter:[[OnlyIntegerValueFormatter alloc] init]];
    [self.heightInput setFormatter:[[OnlyIntegerValueFormatter alloc] init]];
}

- (void) setResolutionLocked:(BOOL) locked{
    _resolutionInputLocked = locked;
    
    [self updateResolutionLockImage];
}

- (void) updateResolutionLockImage{
    self.lockResolutionButton.image = [NSImage imageNamed:_resolutionInputLocked ? @"ic_lock" : @"ic_unlock"];
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    return _dpiTitles.count;
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%@(%d)", _dpiTitles[index], [_dpiResolutions[index] intValue]];
}

- (void) outputClick:(NSButton *) sender{
    NSLog(@"sender:%@, title:%@", sender, sender.title);
    
    if(sender != nil && sender.title != nil){
        [[NSPasteboard generalPasteboard] clearContents];
        [[NSPasteboard generalPasteboard] setString:sender.title forType:NSPasteboardTypeString];
    }
}

- (void) viewDidAppear{
    [super viewDidAppear];
    
//    self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
//    self.statusBarItem.button.title = @"                                 ";
//    
//    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:self.statusBarItem.button.bounds andTitlesImages:@{
//                                                                                                                          @"icon" : @"我是跑马灯，我是跑马灯",
//                                                                                                                          @"ccc" : @"来咬我啊",
//                                                                                                                          @"afaw" : @"啦啦啦啦啦",
//                                                                                                                          @"agwer" : @"哈哈哈哈哈哈"
//                                                                                                                          }];
//    
//    scrollView.bounds = self.statusBarItem.button.layer.bounds;
//    [self.statusBarItem.button addSubview:scrollView];
//    
//    [scrollView startScrolling];
    
    
}

- (int) getDpiInputValue{
    
    return (int) _currentComboBoxSelection;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)calculateButtonClick:(id)sender {
    if(self.widthInput.stringValue != nil && self.heightInput.stringValue != nil){
        int width = [self.widthInput.stringValue intValue];
        int height = [self.heightInput.stringValue intValue];
        
        CGFloat currentDensity = [_dpiDensities[[self getDpiInputValue]] floatValue];
        
        for(int i = 0; i < _dpiViews.count; i++){
            OutputDpiView *outputView = _dpiViews[i];
            
            CGFloat targetDensity = [_dpiDensities[i] floatValue];
            CGFloat scale = targetDensity / currentDensity;
            
            outputView.widthOutput.title = [NSString stringWithFormat:@"%d", (int) (scale * width)];
            outputView.heightOutput.title = [NSString stringWithFormat:@"%d", (int) (scale * height)];
        }
    }
}

- (IBAction)lockResolutionButtonClick:(id)sender {
    
    [self setResolutionLocked:!_resolutionInputLocked];
    
    if(_resolutionInputLocked){
        if([self checkTextFieldEmpty:self.widthInput] && ![self checkTextFieldEmpty:self.heightInput]){
            self.widthInput.stringValue = self.heightInput.stringValue;
        }else if(![self checkTextFieldEmpty:self.widthInput] && [self checkTextFieldEmpty:self.heightInput]){
            self.heightInput.stringValue = self.widthInput.stringValue;
        }else if(![self checkTextFieldEmpty:self.widthInput] && ![self checkTextFieldEmpty:self.heightInput] && ![self.widthInput.stringValue isEqualToString:self.heightInput.stringValue]){
            self.widthInput.stringValue = @"";
            self.heightInput.stringValue = @"";
        }
    }
    
    if(![self checkTextFieldEmpty:self.widthInput] && ![self checkTextFieldEmpty:self.heightInput]){
        [self calculateButtonClick:nil];
    }
}

- (BOOL) checkTextFieldEmpty:(NSTextField *) textField{
    return textField.stringValue == nil || [textField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
}

- (void) controlTextDidChange:(NSNotification *)obj{
    NSTextField *textField = [obj object];
    
    if(_resolutionInputLocked){
        if(textField == self.widthInput){
            self.heightInput.stringValue = textField.stringValue;
        }else if(textField == self.heightInput){
            self.widthInput.stringValue = textField.stringValue;
        }
    }
    
    [self calculateButtonClick:nil];
}

- (void) comboBoxSelectionDidChange:(NSNotification *)notification{
    NSComboBox *comboBox = [notification object];
    
    _currentComboBoxSelection = comboBox.indexOfSelectedItem;
    
    [self calculateButtonClick:nil];
}

@end
