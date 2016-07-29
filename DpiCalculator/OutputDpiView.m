//
//  OutputDpiView.m
//  DpiCalculator
//
//  Created by 7heaven on 16/7/13.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import "OutputDpiView.h"

@implementation OutputDpiView{
    NSView *_contentView;
}

- (instancetype) initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        [self loadContent];
    }
    
    return self;
}

- (instancetype) initWithFrame:(NSRect)frameRect{
    if(self = [super initWithFrame:frameRect]){
        [self loadContent];
    }
    
    return self;
}

- (instancetype) init{
    if(self = [super init]){
        [self loadContent];
    }
    
    return self;
}

- (void) loadContent{
    NSArray *topLevelObjects;
    
    [[NSBundle mainBundle] loadNibNamed:@"OutputDpiView" owner:self topLevelObjects:&topLevelObjects];
    
    for(id topLevelObject in topLevelObjects){
        if([topLevelObject isKindOfClass:[NSView class]]){
            _contentView = topLevelObject;
            break;
        }
    }
    
    if(_contentView != nil){
        self.title = [_contentView viewWithTag:1];
        self.widthLabel = [_contentView viewWithTag:2];
        self.widthOutput = [_contentView viewWithTag:3];
        self.heightLabel = [_contentView viewWithTag:4];
        self.heightOutput = [_contentView viewWithTag:5];
        
        [self addSubview:_contentView];
        _contentView.frame = self.bounds;
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
