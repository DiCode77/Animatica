//
//  Animatica.hpp
//  Animatica
//
//  Created by DiCode77.
//

#ifndef Animatica_hpp
#define Animatica_hpp

#include <iostream>
#include <wx/wx.h>
#include <wx/filename.h>
#include <wx/stdpaths.h>
#include <wx/menu.h>
#include <vector>

#include "obj.hpp"

constexpr const char *APP_VERSION = "0.0.2";

enum{
    ANCA_MENU_CLONE,
    ANCA_MENU_CLOSE
};

class Animatica : public wxFrame{
    ModernizeWindow       *mod_main_window = nullptr;
    Animate               *animate_gif = nullptr;
    std::vector<wxString> vec_name_gif;
    short                 pos_gif = 0;
    bool                  doubleClickIsStatus = false;
    
public:
    Animatica(wxWindow*, const wxString title, const wxPoint point, const wxSize size);
    
    void ChangeSalutation();
    void ChangeDeployment();
    void ChangeButtonsStatus();
    
protected:
    void DoubleClickingTitleBar(wxMaximizeEvent&);
    
    ~Animatica();
    
private:
    void OnActivate(wxActivateEvent&);
    wxString GetFullDirPath(const char*, const char*, const char*);
    void SetInitVectorGif();
    void OnRightClicking(wxMouseEvent&);
    void OnCloneFrame(wxCommandEvent&);
    void OnCloseFrame(wxCommandEvent&);
};

#endif /* Animatica_hpp */

