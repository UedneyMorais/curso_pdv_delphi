unit Users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient,
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
    btnDelete: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure associateFields;
    procedure blockFields;
    procedure enableFields;
    procedure listUsers;
    procedure cleanFields;

    function removeCharactereFromString(value: String): String;
    function formatCpfNumber(cpf: String): String;
    function formatPhoneNumber(phone: String): String;
    function validateFields(): String;
  public
    { Public declarations }
  end;

var
  FrmUsers: TFrmUsers;
  id: String;
  isEditing: boolean;

implementation

{$R *.dfm}
{ TFrmUsers }

uses DbModule;

procedure TFrmUsers.associateFields;
begin
  dm.tb_users.FieldByName('name').value := txtName.Text;
  dm.tb_users.FieldByName('cpf').value := txtCpf.Text;
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

procedure TFrmUsers.btnDeleteClick(Sender: TObject);
begin

  if MessageDlg('Deseja realmente excluir o registro?',
    TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin

    if dm.tb_users.Locate('coduser', id, []) then
    begin
      dm.tb_users.Delete;
      listUsers;
      ShowMessage('Usuário excluído com sucesso!.');
    end
    else
    begin
      ShowMessage('Registro não encontrado.');
    end;

  end;
end;

procedure TFrmUsers.btnEditClick(Sender: TObject);
begin
  dm.tb_users.Edit;
  enableFields();
  btnEdit.Enabled := False;
  btnSave.Enabled := true;
  associateFields();
  isEditing := true;
end;

procedure TFrmUsers.btnNewClick(Sender: TObject);
begin
  isEditing := False;
  btnNew.Enabled := False;
  btnEdit.Enabled := False;
  btnSave.Enabled := true;
  enableFields();
  dm.tb_users.Insert;
end;

procedure TFrmUsers.btnSaveClick(Sender: TObject);
begin

  if validateFields <> '' then
  begin
    ShowMessage('Por favor preencha o campo' + validateFields);
  end
  else

    if isEditing then
  begin
    dm.query_users.Close;
    dm.query_users.SQL.Clear;
    dm.query_users.SQL.Add
      ('UPDATE pdv.users SET name= :name, cpf= :cpf, address= :address, phone= :phone, username= :username, password= :password WHERE coduser= :coduser;');
    dm.query_users.ParamByName('name').AsString := txtName.Text;
    dm.query_users.ParamByName('cpf').AsString := txtCpf.Text;
    dm.query_users.ParamByName('address').AsString := txtAddress.Text;
    dm.query_users.ParamByName('phone').AsString := txtPhone.Text;
    // dm.query_users.ParamByName('codposition').AsString := txtName.Text;
    dm.query_users.ParamByName('username').AsString := txtUsername.Text;
    dm.query_users.ParamByName('password').AsString := txtPassword.Text;
    dm.query_users.ParamByName('coduser').AsString := id;
    dm.query_users.ExecSQL;
    btnEdit.Enabled := False;
    btnSave.Enabled := False;
    btnNew.Enabled := true;
    blockFields;
    listUsers;
    cleanFields;
    ShowMessage('Usuário atualizado com sucesso.');

  end
  else if not isEditing then
  begin

    dm.query_users.SQL.Clear;
    dm.query_users.SQL.Add('SELECT * FROM users WHERE cpf = :cpf');
    dm.query_users.ParamByName('cpf').AsString := txtCpf.Text;
    dm.query_users.Open();

    if not dm.query_users.IsEmpty then
    begin
      ShowMessage('Existe um usuário com este CPF ja cadastrado.');
      exit;
    end
    else
    begin
      associateFields();
      dm.tb_users.Post;
      blockFields();
      btnSave.Enabled := False;
      btnNew.Enabled := true;
      listUsers;
      cleanFields;
      ShowMessage('Usuário salvo com sucesso!');
    end;

  end;

end;

procedure TFrmUsers.cleanFields;
begin
  txtName.Text := '';
  txtCpf.Text := '';
  txtAddress.Text := '';
  txtPhone.Text := '';
  txtUsername.Text := '';
  txtPassword.Text := '';
end;

procedure TFrmUsers.DBGrid1CellClick(Column: TColumn);
var
  cpf, phone: String;
begin

  btnEdit.Enabled := true;
  btnDelete.Enabled := true;
  btnNew.Enabled := False;
  txtName.Text := DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
  txtCpf.Text := DBGrid1.DataSource.DataSet.FieldByName('cpf').AsString;
  txtAddress.Text := DBGrid1.DataSource.DataSet.FieldByName('address').AsString;
  txtPhone.Text := DBGrid1.DataSource.DataSet.FieldByName('phone').AsString;
  txtUsername.Text := dm.query_users.FieldByName('username').value;
  txtPassword.Text := dm.query_users.FieldByName('password').value;
  id := dm.query_users.FieldByName('coduser').value;

end;

procedure TFrmUsers.enableFields;
begin
  txtName.Enabled := true;
  txtCpf.Enabled := true;
  txtAddress.Enabled := true;
  txtPhone.Enabled := true;
  txtUsername.Enabled := true;
  txtPassword.Enabled := true;
end;

function TFrmUsers.formatCpfNumber(cpf: String): String;
var
  formatedCpf: String;
begin
  if Length(cpf) = 11 then

    formatedCpf := Format('%s.%s.%s-%s', [Copy(cpf, 1, 3), Copy(cpf, 4, 3),
      Copy(cpf, 7, 3), Copy(cpf, 10, 2)]);
  Result := formatedCpf;

end;

function TFrmUsers.formatPhoneNumber(phone: String): String;
var
  formatedPhone: String;
begin
  if Length(phone) = 11 then
    formatedPhone := Format('(%s)%s-%s', [Copy(phone, 1, 2), Copy(phone, 2, 4),
      Copy(phone, 4, 4)]);
  Result := formatedPhone;
end;

procedure TFrmUsers.FormCreate(Sender: TObject);
var
  cpfFormated: String;
begin
  dm.tb_users.Active := true;
  blockFields();
  listUsers();
end;

procedure TFrmUsers.listUsers;
begin
  dm.query_users.Close;
  dm.query_users.SQL.Clear();
  dm.query_users.SQL.Add('SELECT * FROM users ORDER BY name ASC');
  dm.query_users.Open();
end;

function TFrmUsers.removeCharactereFromString(value: string): string;
var
  valueReplaced: String;
begin
  value := value.Replace('.', '').Replace('-', '').Replace('(', '')
    .Replace(')', '');
  Result := value;
end;

function TFrmUsers.validateFields: String;
begin

  if Trim(txtName.Text) = '' then
  begin
    txtName.SetFocus;
    Result := ' nome.';
    exit;
  end
  else

    if Trim(txtCpf.Text) = '' then
  begin
    txtCpf.SetFocus;
    Result := ' cpf.';
    exit;
  end
  else

    if Trim(txtAddress.Text) = '' then
  begin
    txtAddress.SetFocus;
    Result := ' endereço.';
    exit;
  end
  else

    if Trim(txtPhone.Text) = '' then
  begin
    txtPhone.SetFocus;
    Result := ' endereço.';
    exit;
  end
  else

    if Trim(txtUsername.Text) = '' then
  begin
    txtUsername.SetFocus;
    Result := ' usuário.';
    exit;
  end
  else

    if Trim(txtPassword.Text) = '' then
  begin
    txtPassword.SetFocus;
    Result := ' senha.';
    exit;
  end
  else
    Result := '';
  exit;
end;

end.
