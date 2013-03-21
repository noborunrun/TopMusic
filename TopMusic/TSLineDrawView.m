//
//  GBLineDrawView.m
//  GenomBrowser
//
//  Created by noboru on 3/13/13.
//  Copyright (c) 2013 NineDrafts Inc. All rights reserved.
//

#import "TSLineDrawView.h"

@implementation TSLineDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    int width = 1;
    int offset = 0;
    
    // コンテキストをゲット
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 線の幅を設定
    CGContextSetLineWidth(context, width);
    for (int i = 0; i < [self.protData count]; i++) {
        if ([[[self.protData objectAtIndex:i] objectAtIndex:3] intValue] == 0) {
            //            NSLog(@"protValue0::%@",[[self.protData objectAtIndex:i] objectAtIndex:0]);
            CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1.0);
        }
        if ([[[self.protData objectAtIndex:i] objectAtIndex:3] intValue] == 1) {
            //            NSLog(@"protValue1::%@",[[self.protData objectAtIndex:i] objectAtIndex:0]);
            CGContextSetRGBStrokeColor(context, 0, 0, 1.0, 1.0);
        }
        CGContextMoveToPoint(context, offset, ([[[self.protData objectAtIndex:i] objectAtIndex:0] floatValue] * 10));
        CGContextAddLineToPoint(context, offset, self.frame.size.height);//線の終点から線を生成
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextStrokePath(context);
        
        offset += width;
    }

}

@end
