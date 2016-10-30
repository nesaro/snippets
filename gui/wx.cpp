//INCLUDES
#ifdef __GNUG__
#endif
#include "wx/wxprec.h"
#ifdef __BORLANDC__
#pragma hdrstop
#endif
#include "wx/wx.h"

//DECLARACIONES
class MyApp: public wxApp
{
  virtual bool OnInit(); //Accion principal
};

class MyFrame: public wxFrame
{
public:
  MyFrame(const wxString & title,
	  const wxPoint & pos,
	  const wxSize & size);
  void OnQuit(wxCommandEvent & event);
  void Onsaludo(wxCommandEvent & event);
  DECLARE_EVENT_TABLE();
private:
  wxPanel * m_panel;
  wxButton * m_btnsaludo;
  wxButton * m_btnQuit;
};

enum { ID_Quit = 1 , ID_saludo };
BEGIN_EVENT_TABLE(MyFrame, wxFrame)
EVT_BUTTON(ID_saludo, MyFrame::Onsaludo)
EVT_BUTTON(ID_Quit, MyFrame::OnQuit)
END_EVENT_TABLE()

//PRINCIPAL
IMPLEMENT_APP(MyApp); //Sustituto de Main


//DEFINICIONES
bool MyApp::OnInit()
{
  MyFrame * frame = new MyFrame ("Hello World",wxPoint(50, 50),wxSize(200, 100));
  frame->Show(TRUE);
  SetTopWindow(frame);
  return TRUE;
}
MyFrame::MyFrame(const wxString & title, const wxPoint & pos, const wxSize & size) : wxFrame((wxFrame *)NULL, -1, title, pos, size)
{
  wxSize panelSize=GetClientSize();
  m_panel = new wxPanel(this, -1 , wxPoint(0,0),panelSize);
  int h = panelSize.GetHeight();
  int w = panelSize.GetWidth();
  m_btnsaludo = new wxButton (m_panel, ID_saludo,_T("Saludo"),wxPoint(w/2-70,h/2-10),wxSize(50,20));
  m_btnQuit = new wxButton (m_panel, ID_Quit,_T("Salir"),wxPoint(w/2+30,h/2-10),wxSize(50,20));
}
void MyFrame::OnQuit(wxCommandEvent & WXUNUSED(event))
{
  Close(TRUE);
}
void MyFrame::Onsaludo(wxCommandEvent & WXUNUSED(event))
{
  //  wxMessageBox("Ejemplo de HelloWorld con wcwindows","Hello World", wxOK| wxICON_INFORMATION,this);
}
