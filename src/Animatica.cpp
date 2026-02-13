//
//  Animatica.cpp
//  Animatica
//
//  Created by DiCode77.
//

#include "Animatica.hpp"

Animatica::Animatica(wxWindow *frame, const wxString title, const wxPoint point, const wxSize size) : wxFrame(frame, wxID_ANY, title, point, size){
    this->SetMinSize(this->GetSize());
    this->SetMaxSize(this->GetSize());
    this->SetInitVectorGif();

    this->mod_main_window = new ModernizeWindow();
    this->mod_main_window->ConnectFrame(this->GetHandle());
    this->mod_main_window->NoColorWindow();
    this->mod_main_window->TopWindow();
    this->mod_main_window->SetTitleText("_");
    this->mod_main_window->HideIconApp();
    
    this->mod_main_window->InitTitleBarButtons();
    this->mod_main_window->SetDelegateButtonMinimaze(std::bind(&Animatica::ChangeSalutation, this));
    this->mod_main_window->SetDelegateButtonZoom(std::bind(&Animatica::ChangeDeployment, this));
    this->mod_main_window->SetDelegateFuncDoubleClick(std::bind(&Animatica::ChangeButtonsStatus, this));

    this->animate_gif = new Animate();
    this->animate_gif->ConnectFrame(this->GetHandle());
    this->animate_gif->loadGif(GetFullDirPath("resources", vec_name_gif[this->pos_gif], "gif"));
    
    this->Bind(wxEVT_MAXIMIZE, &Animatica::DoubleClickingTitleBar, this);
    this->Bind(wxEVT_ACTIVATE, &Animatica::OnActivate, this);
    this->Bind(wxEVT_RIGHT_DOWN, &Animatica::OnRightClicking, this);
    this->Bind(wxEVT_MENU, &Animatica::OnCloneFrame, this, ANCA_MENU_CLONE);
    this->Bind(wxEVT_MENU, &Animatica::OnCloseFrame, this, ANCA_MENU_CLOSE);
}

Animatica::~Animatica(){
    delete this->mod_main_window;
    delete this->animate_gif;
}

void Animatica::OnActivate(wxActivateEvent &event){
    if (!event.GetActive()){
          this->mod_main_window->TopWindow();
    }
    
    event.Skip();
}

wxString Animatica::GetFullDirPath(const char *folder, const char *name, const char *ext){
    wxFileName imagePath(wxStandardPaths::Get().GetExecutablePath());
    imagePath.AppendDir("..");
    imagePath.AppendDir(folder);
    imagePath.SetFullName(name);
    imagePath.SetExt(ext);
    return imagePath.GetFullPath();
}

void Animatica::SetInitVectorGif(){
    this->vec_name_gif.push_back("evernight_1");
    this->vec_name_gif.push_back("evernight_1_1");
    this->vec_name_gif.push_back("evernight_2");
    this->vec_name_gif.push_back("firefly_1");
    this->vec_name_gif.push_back("hoshino_1");
    this->vec_name_gif.push_back("bocchi-1");
    this->vec_name_gif.push_back("yunli1");
    this->vec_name_gif.push_back("anime-dance_1");
    this->vec_name_gif.push_back("ai-oshino-ko1");
    this->vec_name_gif.push_back("animat_1");
    this->vec_name_gif.push_back("mahiro1");
}

void Animatica::OnRightClicking(wxMouseEvent &event){
    wxMenu menu;
    menu.Append(ANCA_MENU_CLONE, "Clone");
    menu.Append(ANCA_MENU_CLOSE, "Close");
    PopupMenu(&menu, event.GetPosition());
}

void Animatica::OnCloneFrame(wxCommandEvent&){
    (new Animatica(nullptr, this->GetTitle(), this->GetPosition() + wxPoint(100, 100), this->GetSize()))->Show();
}

void Animatica::OnCloseFrame(wxCommandEvent&){
    this->Close();
}

void Animatica::ChangeSalutation(){
    if (this->pos_gif > 0){
        this->pos_gif--;
    }
    else{
        this->pos_gif = this->vec_name_gif.size() -1;
    }
    
    this->animate_gif->loadGif(GetFullDirPath("resources", vec_name_gif[this->pos_gif], "gif"));
}

void Animatica::ChangeDeployment(){
    if (this->pos_gif >= (this->vec_name_gif.size() -1)){
        this->pos_gif = 0;
    }
    else{
        this->pos_gif++;
    }
    
    this->animate_gif->loadGif(GetFullDirPath("resources", vec_name_gif[this->pos_gif], "gif"));
}

void Animatica::ChangeButtonsStatus(){
    wxMaximizeEvent state = wxMaximizeEvent();
    DoubleClickingTitleBar(state);
}

void Animatica::DoubleClickingTitleBar(wxMaximizeEvent&){
    if (this->doubleClickIsStatus){
        this->mod_main_window->TitleBarAllButtonShow();
    }
    else{
        this->mod_main_window->TitleBarAllButtonHide();
    }
    
    this->doubleClickIsStatus = !this->doubleClickIsStatus;
}
