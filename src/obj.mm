//
//  obj.mm
//  Animatica
//
//  Created by DiCode77.
//

#import "objm.h"
#import "obj.hpp"

@implementation CustomWindowDelegate {
    ModernizeWindow *m_window;
}

- (instancetype)initWithModernizeWindow:(ModernizeWindow*)md_window {
    self = [super init];
    if (self) {
        if (md_window != nil) {
            m_window = static_cast<ModernizeWindow*>(md_window);
        }
    }
    return self;
}

- (void)WindowReduction:(id)sender{
    if (m_window != nil)
        m_window->CallWindowReduction();
}

- (void)WindowEnlargement:(id)sender{
    if (m_window != nil)
        m_window->CallWindowEnlargement();
}
@end

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

void ModernizeWindow::TopWindow(){
    [this->nsWindow setLevel:NSModalPanelWindowLevel];
}

void ModernizeWindow::HideTitleText(){
    [this->nsWindow setTitleVisibility:NSWindowTitleHidden];
}

void ModernizeWindow::SetDelegateReduction(std::function<void()> func){
    MakeDelegation();
    
    if (this->minimizeButton != nil){
        [minimizeButton setTarget:static_cast<CustomWindowDelegate*>(this->CustomWindowDel)];
        [minimizeButton setAction:@selector(WindowReduction:)];
        this->c_windowReduc = func;
    }
}

void ModernizeWindow::SetDelegateEnlargement(std::function<void()> func){
    MakeDelegation();
    
    if (this->zoomButton != nil){
        [zoomButton setTarget:static_cast<CustomWindowDelegate*>(this->CustomWindowDel)];
        [zoomButton setAction:@selector(WindowEnlargement:)];
        this->c_windowEnlar = func;
    }
}

void ModernizeWindow::TitleBarButtonsInit(){
    if (this->nsWindow != nil){
        this->closeButton    = [this->nsWindow standardWindowButton:NSWindowCloseButton];
        this->minimizeButton = [this->nsWindow standardWindowButton:NSWindowMiniaturizeButton];
        this->zoomButton     = [this->nsWindow standardWindowButton:NSWindowZoomButton];
    }
}

void ModernizeWindow::CallWindowReduction(){
    if (this->c_windowReduc)
        this->c_windowReduc();
}

void ModernizeWindow::CallWindowEnlargement(){
    if (this->c_windowEnlar)
        this->c_windowEnlar();
}

void ModernizeWindow::TitleBarAllButtonShow(){
    HideAllButtonsInTitleBar(YES);
}

void ModernizeWindow::TitleBarAllButtonHide(){
    HideAllButtonsInTitleBar(NO);
}

ModernizeWindow::~ModernizeWindow(){
    if (this->CustomWindowDel != nullptr){
        [static_cast<CustomWindowDelegate*>(this->CustomWindowDel) release];
        this->CustomWindowDel = nullptr;
    }
}

void ModernizeWindow::_conFrame(NSWindow *window){
    this->nsWindow = window;
}

void ModernizeWindow::MakeDelegation(){
    if (this->CustomWindowDel == nullptr){
        this->CustomWindowDel = static_cast<void*>([[CustomWindowDelegate alloc] initWithModernizeWindow:this]);
    }
}

void ModernizeWindow::HideAllButtonsInTitleBar(bool isStatus){
    if (this->closeButton != nil)
        [this->closeButton setHidden:isStatus];
    if (this->minimizeButton != nil)
        [this->minimizeButton setHidden:isStatus];
    if (this->zoomButton != nil)
        [this->zoomButton setHidden:isStatus];
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

Animate::~Animate(){
    if (this->image != nil){
        [this->image release];
        this->image = nil;
    }
    
    if (this->imageView != nil){
        [this->imageView removeFromSuperview]; // delete gif
        [this->imageView release]; // free memory
        this->imageView = nil;
    }
}
