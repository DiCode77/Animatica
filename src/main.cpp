//
//  main.cpp
//  Animatica
//
//  Created by DiCode77.
//

#include "main.hpp"

bool MyApp::OnInit() {
    Animatica *prog = new Animatica(wxT("Animatica"), wxDefaultPosition, wxSize(400, 500));
    prog->Show(true);
    return true;
}

wxIMPLEMENT_APP(MyApp);