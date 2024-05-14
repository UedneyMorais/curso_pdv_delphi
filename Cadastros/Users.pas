unit Users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
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
    txtUsername: TEdit;
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
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure associateFields;
    procedure blockFields;
    procedure enableFields;
    procedure listUsers;

    function removeCharactereFromString(value: String): String;

  public
    { Public declarations }
  end;

var
  FrmUsers: TFrmUsers;

implementation

{$R *.dfm}
{ TFrmUsers }

uses DbModule;

procedure TFrmUsers.associateFields;
begin
  dm.tb_users.FieldByName('name').value := txtName.Text;
  dm.tb_users.FieldByName('cpf').value := removeCharactereFromString
    (txtCpf.Text);
  dm.tb_users.FieldByName('address').value := txtAddress.Text;
  dm.tb_users.FieldByName('phone').value := txtPhone.Text;
  dm.tb_users.FieldByName('username').value := txtUsername.Text;
  dm.tb_users.FieldByName('password').value := txtPassword.Text;

end;

procedure TFrmUsers.blockFields;
begin
  txtName.Enabled := False;
  txtCpf.Enabled := False;
  txtAddress.Enabled := False;
  txtPhone.Enabled := False;
  txtUsername.Enabled := False;
  txtPassword.Enabled := False;
end;

procedure TFrmUsers.btnNewClick(Sender: TObject);
begin

  btnNew.Enabled := False;
  btnEdit.Enabled := False;
  btnSave.Enabled := True;
  enableFields();

  dm.tb_users.Insert;

end;

procedure TFrmUsers.btnSaveClick(Sender: TObject);
begin
  associateFields();
  dm.tb_users.Post;
  blockFields();
  btnSave.Enabled := False;
  btnNew.Enabled := True;
  ShowMessage('Usu�rio salvo com sucesso!');
end;

procedure TFrmUsers.enableFields;
begin
  txtName.Enabled := True;
  txtCpf.Enabled := True;
  txtAddress.Enabled := True;
  txtPhone.Enabled := True;
  txtUsername.Enabled := True;
  txtPassword.Enabled := True;
end;

procedure TFrmUsers.FormCreate(Sender: TObject);
begin

  dm.tb_users.Active := True;
  blockFields();
end;

procedure TFrmUsers.listUsers;
begin
  dm.query_users.Close;
  dm.query_users.SQL.Clear();
  dm.query_users.SQL.Add('SELECT * FROM users order by name asc');
  dm.query_users.Open();
end;

function TFrmUsers.removeCharactereFromString(value: String): String;
var
  valueReplaced: String;
begin
  value := value.Replace('.', '').Replace('-', '').Replace('(', '')
    .Replace(')', '');
  Result := value;
end;

end.
