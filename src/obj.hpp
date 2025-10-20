//
//  obj.hpp
//  Animatica
//
//  Created by DiCode77.
//

#ifndef obj_hpp
#define obj_hpp

#ifdef __OBJC__
#else
  class NSWindow;
  class NSImage;
  class NSImageView;
#endif

#include <wx/wx.h>
#include <functional>

class ModernizeWindow{
    NSButton *minimizeButton = nullptr;
    NSButton *zoomButton = nullptr;
    NSButton *closeButton = nullptr;
public:
    NSWindow *nsWindow = nullptr;
    void *CustomWindowDel = nullptr;
public:
    std::function<void()> c_windowReduc = NULL;
    std::function<void()> c_windowEnlar = NULL;
    
public:
    void ConnectFrame(WXWidget);
    void NoColorWindow();
    void TopWindow();
    void HideTitleText();
    void SetDelegateReduction(std::function<void()>);
    void SetDelegateEnlargement(std::function<void()>);
    
    void TitleBarButtonsInit();
    
    void CallWindowReduction();
    void CallWindowEnlargement();
    
    void TitleBarAllButtonShow();
    void TitleBarAllButtonHide();
    
    ~ModernizeWindow();
private:
    void _conFrame(NSWindow*);
    void MakeDelegation();
    void HideAllButtonsInTitleBar(bool);
};

class Animate{
    NSWindow *nsWindow = nullptr;
    NSImage *image = nullptr;
    NSImageView *imageView = nullptr;
public:
    
    void ConnectFrame(WXWidget);
    void loadGif(wxString);
    void AutoResizeGifOn();
    void Show();
    void Hide();
    
    ~Animate();
    
private:
    void _conFrame(NSWindow*);
};

#endif /* obj_hpp */
