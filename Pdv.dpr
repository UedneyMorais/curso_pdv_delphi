program Pdv;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  Users in 'Cadastros\Users.pas' {FrmUsers},
  DbModule in 'DbModule.pas' {dm: TDataModule},
  Menu in 'Menu.pas' {FrmMenu},
  Employee in 'Cadastros\Employee.pas' {FrmEmployee},
  Office in 'Cadastros\Office.pas' {FrmOffice};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmEmployee, FrmEmployee);
  Application.CreateForm(TFrmOffice, FrmOffice);
  Application.Run;
end.
