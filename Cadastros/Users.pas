unit Users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmUsers = class(TForm)
    Label1: TLabel;
    txtName: TEdit;
    Label2: TLabel;
    txtAddress: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    txtPassword: TEdit;
    Label7: TLabel;
    txtPhone: TMaskEdit;
    txtCpf: TMaskEdit;
    DBGrid1: TDBGrid;
    btnNew: TSpeedButton;
    btnEdit: TSpeedButton;
    btnSave: TSpeedButton;
    SpeedButton3: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUsers: TFrmUsers;

implementation

{$R *.dfm}

end.
