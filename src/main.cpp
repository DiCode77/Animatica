//
//  main.cpp
//  Animatica
//
//  Created by DiCode77.
//

#include "main.hpp"

bool MyApp::OnInit() {
    Animatica *prog = new Animatica(nullptr, wxT("Animatica"), wxDefaultPosition, wxSize(220, 280));
    prog->Show(true);
    return true;
}

wxIMPLEMENT_APP(MyApp);
