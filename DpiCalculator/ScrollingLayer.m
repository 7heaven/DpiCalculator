//
//  ScrollingView.m
//  DpiCalculator
//
//  Created by 7heaven on 16/7/18.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import "ScrollingLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation ScrollingLayer{
    dispatch_queue_t _queue;
    dispatch_source_t _timer;
    
    unsigned long _titleIndex;
    
    CGContextRef _context;
    
    NSString *_topText;
    NSString *_bottomText;
}

@dynamic scrollingProgress;

- (instancetype) initWithFrame:(NSRect)frameRect andTitlesImages:(NSDictionary *) titlesImages{
    if(self = [super init]){
        self.bounds = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height);
        [self initWithTitlesAndImages:titlesImages];
    }
    
    return self;
}

- (void) initWithTitlesAndImages:(NSDictionary *) titlesAndImages{
    
}

- (id<CAAction>) actionForKey:(NSString *)event{
    if([event isEqualToString:@"scrollingProgress"]){
        CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:event];
        progressAnimation.duration = 0.5f;
        progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        progressAnimation.fromValue = @(0);
        progressAnimation.toValue = @(1);
//        progressAnimation.repeatCount = INFINITY;
        
        return progressAnimation;
        
    }
    
    return [super actionForKey:event];
}

+ (BOOL) needsDisplayForKey:(NSString *) key{
    if([key isEqualToString:@"scrollingProgress"]){
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void) startScrolling{
    if(self.titlesAndImages != nil && self.titlesAndImages.allKeys.count > 1){
        _queue = dispatch_queue_create("timer", nil);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
        
        dispatch_source_set_event_handler(_timer, ^{
            if(_titleIndex >= self.titlesAndImages.allKeys.count){
                _titleIndex = 0;
            }
            
            [self animateTitleChange];
            
            _titleIndex++;
        });
        dispatch_resume(_timer);
    }
}

- (void) animateTitleChange{
    if(_titleIndex == self.titlesAndImages.allKeys.count - 1){
        _topText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex]];
        _bottomText = self.titlesAndImages[self.titlesAndImages.allKeys[0]];
    }else{
        _topText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex]];
        _bottomText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex + 1]];
    }
    self.scrollingProgress = arc4random() * M_PI;
}

- (void) display{
    if(_context == nil){
        _context = [[NSGraphicsContext currentContext] graphicsPort];
    }
    
    if(_topText != nil && _bottomText != nil){
//        CGRect viewBounds = self.bounds;
//        CGContextTranslateCTM(_context, 0, viewBounds.size.height);
//        CGContextScaleCTM(_context, 1, -1);
//        CGContextSetRGBFillColor(_context, 0.0, 1.0, 0.0, 1.0);
//        CGContextSetLineWidth(_context, 2.0);
//        CGContextSelectFont(_context, "Helvetica", 10.0, kCGEncodingFontSpecific);
//        CGContextSetCharacterSpacing(_context, 1.7);
//        CGContextSetTextDrawingMode(_context, kCGTextFill);
//        CGContextShowTextAtPoint(_context, 100.0, 100.0, "SOME TEXT", 9);
        
        CGContextSetRGBFillColor(_context, 1.0, 0.0, 0.0, 1.0);
        CGContextAddRect(_context, CGRectMake(0, 0, 60, 150));
        CGContextFillPath(_context);
    }
}

@end
