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
#include <unordered_map>
#include <utility>

constexpr const char *TITLE_BAR_CLOSE_BUTTON = "Close";
constexpr const char *TITLE_BAR_MINIM_BUTTON = "Minimaze";
constexpr const char *TITLE_BAR_ZOOM_BUTTON  = "Zoom";

class ModernizeWindow{
    NSButton *minimizeButton = nullptr;
    NSButton *zoomButton = nullptr;
    NSButton *closeButton = nullptr;
public:
    NSWindow *nsWindow = nullptr;
    void *CustomWindowDel = nullptr;
    std::unordered_map<std::string, std::function<void()>> um_funcv;
    
public:
    void ConnectFrame(WXWidget);
    void NoColorWindow();
    void TopWindow();
    void HideTitleText();
    void SetTitleText(wxString);
    
    void InitTitleBarButtons();
    void SetDelegateButtonClose(std::function<void()>);
    void SetDelegateButtonMinimaze(std::function<void()>);
    void SetDelegateButtonZoom(std::function<void()>);
    
    void TitleBarAllButtonShow();
    void TitleBarAllButtonHide();
    void HideButtonInTBar(const char*, bool);
    
    ~ModernizeWindow();
    
    void _CellUmFunc(std::string);
private:
    void _conFrame(NSWindow*);
    void _MakeDelegation();
    void _InitUMapFunc(std::pair<std::string, std::function<void()>>);
    void _HideAllButtonsInTitleBar(bool);
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
