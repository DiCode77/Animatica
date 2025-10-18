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

#include "Animatica.hpp"


class ModernizeWindow{
    NSWindow *nsWindow;
public:
    void ConnectFrame(WXWidget);
    void NoColorWindow();
    
private:
    void _conFrame(NSWindow*);
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
    
private:
    void _conFrame(NSWindow*);
};

#endif /* obj_hpp */
