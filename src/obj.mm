//
//  obj.mm
//  Animatica
//
//  Created by DiCode77.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "obj.hpp"

void ModernizeWindow::ConnectFrame(WXWidget frame){
    NSView *nsView = (NSView*)frame;
    if (nsView == nil) {
        return;
    }
    else{
        _conFrame(nsView.window);
    }
}

void ModernizeWindow::NoColorWindow(){
    this->nsWindow.opaque = NO;
    this->nsWindow.hasShadow = NO;
    this->nsWindow.backgroundColor = [NSColor clearColor];
    this->nsWindow.titlebarAppearsTransparent = YES;
    this->nsWindow.movableByWindowBackground = YES;
}

void ModernizeWindow::_conFrame(NSWindow *window){
    this->nsWindow = window;
}

void Animate::ConnectFrame(WXWidget frame){
    NSView *nsView = (NSView*)frame;
    if (nsView == nil) {
        return;
    }
    else{
        if (nsView.window.contentView){
            _conFrame(nsView.window);
        }
        else{
            NSLog(@"<contentView> Not active!");
        }
    }
}

void Animate::loadGif(wxString dir){
    if (this->nsWindow != nil){
        if (this->image != nil){
            [this->image release];
            this->image = nil;
        }
        
        this->image = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithUTF8String:dir.utf8_str()]];
        if (!image){
            return;
        }
        
        if (this->imageView != nil){
            [this->imageView removeFromSuperview]; // delete gif
            [this->imageView release]; // free memory
            this->imageView = nil;
        }
        
        this->imageView = [[NSImageView alloc] initWithFrame:this->nsWindow.contentView.bounds];
        
        this->imageView.image = this->image;
        this->imageView.animates = YES;
        this->imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
        this->imageView.wantsLayer = YES;
        this->imageView.layer.backgroundColor = [NSColor clearColor].CGColor;
        this->imageView.layer.opaque = NO;
        
        [this->nsWindow.contentView addSubview:this->imageView];
    }
}

void Animate::AutoResizeGifOn(){
    this->imageView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

void Animate::_conFrame(NSWindow *frame){
    this->nsWindow = frame;
}

void Animate::Show(){
    [this->imageView setHidden:NO];
}

void Animate::Hide(){
    [this->imageView setHidden:YES];
}
