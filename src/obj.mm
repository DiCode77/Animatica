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

- (void)WindowCloseWindow:(id)sender{
    if (m_window != nil)
        m_window->_CellUmFunc(TITLE_BAR_CLOSE_BUTTON);
}

- (void)WindowMinimaze:(id)sender{
    if (m_window != nil)
        m_window->_CellUmFunc(TITLE_BAR_MINIM_BUTTON);
}

- (void)WindowZoom:(id)sender{
    if (m_window != nil)
        m_window->_CellUmFunc(TITLE_BAR_ZOOM_BUTTON);
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
    if (this->nsWindow != nil){
        [this->nsWindow makeKeyAndOrderFront:nil];
        [this->nsWindow setLevel:NSModalPanelWindowLevel];
    }
}

void ModernizeWindow::HideTitleText(){
    if (this->nsWindow != nil)
        [this->nsWindow setTitleVisibility:NSWindowTitleHidden];
}

void ModernizeWindow::SetTitleText(wxString name){
    if (this->nsWindow != nil)
        [this->nsWindow setTitle:[NSString stringWithUTF8String:name.utf8_str()]];
}

void ModernizeWindow::InitTitleBarButtons(){
    if (this->nsWindow != nil){
        this->closeButton    = [this->nsWindow standardWindowButton:NSWindowCloseButton];
        this->minimizeButton = [this->nsWindow standardWindowButton:NSWindowMiniaturizeButton];
        this->zoomButton     = [this->nsWindow standardWindowButton:NSWindowZoomButton];
                
        _MakeDelegation();
    }
}

void ModernizeWindow::SetDelegateButtonClose(std::function<void()> func){
    if (this->closeButton != nil && this->CustomWindowDel != nil){
        [this->closeButton setTarget:static_cast<CustomWindowDelegate*>(this->CustomWindowDel)];
        [this->closeButton setAction:@selector(WindowCloseWindow:)];
        _InitUMapFunc(std::make_pair(TITLE_BAR_CLOSE_BUTTON, func));
        
    }
}

void ModernizeWindow::SetDelegateButtonMinimaze(std::function<void()> func){
    if (this->minimizeButton != nil && this->CustomWindowDel != nil){
        [this->minimizeButton setTarget:static_cast<CustomWindowDelegate*>(this->CustomWindowDel)];
        [this->minimizeButton setAction:@selector(WindowMinimaze:)];
        _InitUMapFunc(std::make_pair(TITLE_BAR_MINIM_BUTTON, func));
    }
}

void ModernizeWindow::SetDelegateButtonZoom(std::function<void()> func){
    if (this->zoomButton != nil && this->CustomWindowDel != nil){
        [this->zoomButton setTarget:static_cast<CustomWindowDelegate*>(this->CustomWindowDel)];
        [this->zoomButton setAction:@selector(WindowZoom:)];
        _InitUMapFunc(std::make_pair(TITLE_BAR_ZOOM_BUTTON, func));
    }
}

void ModernizeWindow::TitleBarAllButtonShow(){
    _HideAllButtonsInTitleBar(NO);
}

void ModernizeWindow::TitleBarAllButtonHide(){
    _HideAllButtonsInTitleBar(YES);
}

void ModernizeWindow::HideButtonInTBar(const char *name, bool isStatus){
    if (!std::strcmp(TITLE_BAR_CLOSE_BUTTON, name)){
        if (this->closeButton != nil)
            [this->closeButton setHidden:isStatus];
    }
    else if (!std::strcmp(TITLE_BAR_MINIM_BUTTON, name)){
        if (this->minimizeButton != nil)
            [this->minimizeButton setHidden:isStatus];
    }
    else if (!std::strcmp(TITLE_BAR_ZOOM_BUTTON, name)){
        if (this->zoomButton != nil)
            [this->zoomButton setHidden:isStatus];
    }
    else{
    }
}

ModernizeWindow::~ModernizeWindow(){
    if (this->CustomWindowDel != nullptr){
        [static_cast<CustomWindowDelegate*>(this->CustomWindowDel) release];
        this->CustomWindowDel = nullptr;
    }
}

void ModernizeWindow::_CellUmFunc(std::string name){
    if (this->um_funcv.contains(name)){
        this->um_funcv.at(name)();
    }
}

void ModernizeWindow::_conFrame(NSWindow *window){
    this->nsWindow = window;
}

void ModernizeWindow::_MakeDelegation(){
    if (this->CustomWindowDel == nullptr){
        this->CustomWindowDel = static_cast<void*>([[CustomWindowDelegate alloc] initWithModernizeWindow:this]);
    }
}

void ModernizeWindow::_InitUMapFunc(std::pair<std::string, std::function<void()>> func){
    this->um_funcv.insert(func);
}

void ModernizeWindow::_HideAllButtonsInTitleBar(bool isStatus){
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
