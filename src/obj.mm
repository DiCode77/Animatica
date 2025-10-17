#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "obj.hpp"

void ModernizeFrame(WXWidget frame){
    NSView *nsView = (NSView*)frame;
    if (nsView == nil) {
        return;
    }
    else{
        NSWindow* nsWindow = nsView.window;
        
        nsWindow.opaque = NO;
        nsWindow.hasShadow = NO;
        nsWindow.backgroundColor = [NSColor clearColor];
        nsWindow.titlebarAppearsTransparent = YES;
        nsWindow.movableByWindowBackground = YES;
    }
}
