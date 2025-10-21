//
//  Animatica.cpp
//  Animatica
//
//  Created by DiCode77.
//

#include "Animatica.hpp"

Animatica::Animatica(const wxString title, const wxPoint point, const wxSize size) : wxFrame(nullptr, wxID_ANY, title, point, size){
    this->SetMinSize(this->GetSize());
    this->SetMaxSize(this->GetSize());
    this->SetInitVectorGif();

    this->mod_main_window = new ModernizeWindow();
    this->mod_main_window->ConnectFrame(this->GetHandle());
    this->mod_main_window->NoColorWindow();
    this->mod_main_window->TopWindow();
    this->mod_main_window->SetTitleText("_");
    
    this->mod_main_window->InitTitleBarButtons();
    this->mod_main_window->SetDelegateButtonMinimaze(std::bind(&Animatica::ChangeSalutation, this));
    this->mod_main_window->SetDelegateButtonZoom(std::bind(&Animatica::ChangeDeployment, this));

    this->animate_gif = new Animate();
    this->animate_gif->ConnectFrame(this->GetHandle());
    this->animate_gif->loadGif(GetFullDirPath("resources", vec_name_gif[this->pos_gif], "gif"));


    this->Bind(wxEVT_MAXIMIZE, &Animatica::DoubleClickingTitleBar, this);
    this->Bind(wxEVT_ACTIVATE, &Animatica::OnActivate, this);
}

Animatica::~Animatica(){
    delete this->mod_main_window;
    delete this->animate_gif;
}

void Animatica::OnActivate(wxActivateEvent& event){
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
    this->vec_name_gif.push_back("evernight_2");
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


void Animatica::DoubleClickingTitleBar(wxMaximizeEvent&){
    if (this->doubleClickIsStatus){
        this->mod_main_window->TitleBarAllButtonShow();
    }
    else{
        this->mod_main_window->TitleBarAllButtonHide();
    }
    
    this->doubleClickIsStatus = !this->doubleClickIsStatus;
}
