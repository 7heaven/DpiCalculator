//
//  ScrollView.m
//  DpiCalculator
//
//  Created by 7heaven on 16/7/18.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import "ScrollView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ScrollView{
    dispatch_queue_t _queue;
    dispatch_source_t _timer;
    
    unsigned long _titleIndex;
    
    CGContextRef _context;
    
    NSString *_topText;
    NSString *_bottomText;
    
    NSTextField *_topTextField;
    NSTextField *_bottomTextField;
}

- (instancetype) initWithFrame:(NSRect)frameRect andTitlesImages:(NSDictionary *) titlesImages{
    if(self = [super initWithFrame:frameRect]){
//        self.frame = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height);
        _topTextField = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height)];
        _bottomTextField = [[NSTextField alloc] initWithFrame:CGRectMake(0, frameRect.size.height, frameRect.size.width, frameRect.size.height)];
        
        _topTextField.font = [NSFont systemFontOfSize:14.0f];
        _bottomTextField.font = [NSFont systemFontOfSize:14.0f];
        _topTextField.drawsBackground = NO;
        _topTextField.bezeled = NO;
        _topTextField.editable = NO;
        _bottomTextField.drawsBackground = NO;
        _bottomTextField.bezeled = NO;
        _bottomTextField.editable = NO;
        
        [self initWithTitlesAndImages:titlesImages];
        
        [self addSubview:_topTextField];
        [self addSubview:_bottomTextField];
        
        self.titlesAndImages = titlesImages;
    }
    
    return self;
}

- (NSView *) hitTest:(NSPoint) aPoint{
    return nil;
}

- (void) initWithTitlesAndImages:(NSDictionary *) titlesAndImages{
    
}

- (void) startScrolling{
    if(self.titlesAndImages != nil && self.titlesAndImages.allKeys.count > 1){
        _queue = dispatch_queue_create("timer", nil);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
        
        _topText = @"";
        _bottomText = @"";
        
        dispatch_source_set_event_handler(_timer, ^{
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(_titleIndex >= self.titlesAndImages.allKeys.count){
                    _titleIndex = 0;
                }
                [self animateTitleChange];
                NSLog(@"_topText:%@, _bottomText:%@", _topText, _bottomText);
                _titleIndex++;
            });
            
            
            
            
        });
        dispatch_resume(_timer);
    }
}

- (void) animateTitleChange{
    _topTextField.frame = (CGRect){0, 0, _topTextField.frame.size};
    _bottomTextField.frame = (CGRect){0, _bottomTextField.frame.size.height, _bottomTextField.frame.size};
    
    if(_titleIndex == self.titlesAndImages.allKeys.count - 1){
        _topText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex]];
        _bottomText = self.titlesAndImages[self.titlesAndImages.allKeys[0]];
    }else{
        _topText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex]];
        _bottomText = self.titlesAndImages[self.titlesAndImages.allKeys[_titleIndex + 1]];
    }
    
    _topTextField.stringValue = _topText;
    _bottomTextField.stringValue = _bottomText;
    
//    NSMutableDictionary *firstDict = [NSMutableDictionary dictionary];
//    [firstDict setObject:_topTextField forKey:NSViewAnimationTargetKey];
//    [firstDict setObject:[NSValue valueWithRect:(CGRect){0, 0, _topTextField.frame.size}] forKey:NSViewAnimationStartFrameKey];
//    [firstDict setObject:[NSValue valueWithRect:(CGRect){0, -_topTextField.frame.size.height, _topTextField.frame.size}] forKey:NSViewAnimationEndFrameKey];
//    
//    NSMutableDictionary *secondDict = [NSMutableDictionary dictionary];
//    [secondDict setObject:_bottomTextField forKey:NSViewAnimationTargetKey];
//    [secondDict setObject:[NSValue valueWithRect:(CGRect){0, _bottomTextField.frame.size.height, _bottomTextField.frame.size}] forKey:NSViewAnimationStartFrameKey];
//    [secondDict setObject:[NSValue valueWithRect:(CGRect){0, 0, _bottomTextField.frame.size}] forKey:NSViewAnimationEndFrameKey];
//    
//    NSViewAnimation *firstAnimation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:firstDict]];
//    [firstAnimation setDuration:2.0];
//    
//    NSViewAnimation *secondAnimation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:secondDict]];
//    [secondAnimation setDuration:2.0];

    
//    CABasicAnimation *firstAnimation = [CABasicAnimation animationWithKeyPath:@"frameOrigin"];
//    firstAnimation.duration = 0.5F;
//    firstAnimation.delegate = self;
////    firstAnimation.fromValue = @(0);
////    firstAnimation.toValue = @(1);
//    firstAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    CABasicAnimation *secondAnimation = [CABasicAnimation animationWithKeyPath:@"frameOrigin"];
//    secondAnimation.duration = 0.5F;
//    secondAnimation.delegate = self;
////    secondAnimation.fromValue = @(1);
////    secondAnimation.toValue = @(0);
//    secondAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
//    [[_topTextField layer] addAnimation:firstAnimation forKey:@"transform"];
//    [[_bottomTextField layer] addAnimation:secondAnimation forKey:@"transform"];
//    _topTextField.layer.opacity = 1;
//    _bottomTextField.layer.opacity = 0;
//    [_topTextField setAnimations:firstDict];
//    [_bottomTextField setAnimations:secondDict];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.5F;
        
        
//        [_topTextField setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:firstAnimation, @"frameOrigin", nil]];
//        [_bottomTextField setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:secondAnimation, @"frameOrigin", nil]];
//        [[_topTextField animator] setFrame:NSMakeRect(0, -_topTextField.frame.size.height, _topTextField.frame.size.width, _topTextField.frame.size.height)];
//        [[_bottomTextField animator] setFrame:(CGRect){0, 0, _bottomTextField.frame.size}];
        [[_topTextField animator] setFrameOrigin:NSMakePoint(0, -_topTextField.frame.size.height)];
        [[_bottomTextField animator] setFrameOrigin:NSMakePoint(0, 0)];
    } completionHandler:^{
        
    }];
}

@end
