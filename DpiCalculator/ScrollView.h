//
//  ScrollView.h
//  DpiCalculator
//
//  Created by 7heaven on 16/7/18.
//  Copyright © 2016年 7heaven. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ScrollView;

@protocol ScrollViewProtocol

@optional

- (void) scrollingView:(ScrollView *) scrollView
        didChangeTitle:(NSString *) title
              andImage:(NSImage *) image
             newLength:(CGFloat) length;

@end

@interface ScrollView : NSView

- (instancetype) initWithFrame:(NSRect)frameRect andTitlesImages:(NSDictionary *) titlesImages;

@property (strong, nonatomic) NSDictionary *titlesAndImages;

@property (weak, nonatomic) id<ScrollViewProtocol> scrollDelegate;

@property (assign, nonatomic) CGFloat scrollingProgress;

- (void) startScrolling;


@end
