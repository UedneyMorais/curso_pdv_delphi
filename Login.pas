unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    pnlLogin: TPanel;
    Image2: TImage;
    txtUsername: TEdit;
    txtPassword: TEdit;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Login;
    procedure centerPanel;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses DbModule, Menu;

procedure TFrmLogin.centerPanel;
begin
  pnlLogin.Top := (Self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (Self.Width div 2) - (pnlLogin.Width div 2)
end;

procedure TFrmLogin.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  centerPanel;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  centerPanel();
  dm.tb_users.Active := True;
  dm.query_users.Active := True;
end;

procedure TFrmLogin.Login;
var
  username, password: String;
  query: String;
begin

  if Trim(txtUsername.Text) = '' then
  begin
    ShowMessage('Preencha o campo usu�rio.');
    txtUsername.SetFocus;

  end
  else if Trim(txtPassword.Text) = '' then
  begin
    ShowMessage('Preencha o campo senha.');
    txtPassword.SetFocus;

  end
  else
  begin
    query := 'SELECT * FROM users u WHERE u.username  = :username AND u.password  = :password limit 1';
    dm.query_users.Close;
    dm.query_users.SQL.Clear;
    dm.query_users.SQL.Add(query);
    dm.query_users.ParamByName('username').AsString := txtUsername.Text;
    dm.query_users.ParamByName('password').AsString := txtPassword.Text;

    // Abre a consulta
    dm.query_users.Open;

    // Verifica se a consulta retornou resultados
    if not dm.query_users.IsEmpty then
    begin
      FrmMenu := TFrmMenu.Create(Self); // Altera��o aqui
      FrmMenu.Show; // Se desejar que o formul�rio seja modal
       // Libera a mem�ria alocada para o formul�ri

    end
    else
    begin
      // Se n�o houver resultados, exibe uma mensagem de erro
      ShowMessage('Usu�rio ou senha incorretos.');

    end;
  end;
end;

procedure TFrmLogin.SpeedButton1Click(Sender: TObject);
begin
  Login();
end;

end.
