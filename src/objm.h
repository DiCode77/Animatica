//
//  objm.hpp
//  Animatica
//
//  Created by DiCode77.
//


#ifndef objm_hpp
#define objm_hpp

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface CustomWindowDelegate : NSObject <NSWindowDelegate>
@property (nonatomic, assign) CFTimeInterval lastVal;
@end

#endif
