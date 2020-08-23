//
//  NSString+WidthHeight.h
//  XFHLMeeting
//
//  Created by xixi_wen on 2019/1/28.
//  Copyright © 2019 XFHL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WidthHeight)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
