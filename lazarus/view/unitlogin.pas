unit unitLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  unitCampoUtils, DB, LCLType, ZConnection, ZDataset, unitPrincipal;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    bbtnEntrar: TBitBtn;
    imgLogo: TImage;
    ledSenha: TLabeledEdit;
    ledUsuario: TLabeledEdit;
    zcEstacionamento: TZConnection;
    zroqLogar: TZReadOnlyQuery;
    zroqLogarATIVO: TStringField;
    zroqLogarDATA_CADASTRO: TDateTimeField;
    zroqLogarID: TLongintField;
    zroqLogarLOGIN: TStringField;
    zroqLogarSENHA: TStringField;
    procedure bbtnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ledSenhaKeyPress(Sender: TObject; var Key: char);
    procedure ledUsuarioKeyPress(Sender: TObject; var Key: char);
  private
    campoUtils: TCampoUtils;
    procedure Criticas;

  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.ledUsuarioKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Criticas;
    ledSenha.SetFocus;
  end;
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  campoUtils := TCampoUtils.Create;
end;

procedure TFormLogin.bbtnEntrarClick(Sender: TObject);
begin
  Criticas;
  zroqLogar.Close;
  zroqLogar.ParamByName('pLOGIN').Value := ledUsuario.Text;
  zroqLogar.Open;
  if not (zroqLogarLOGIN.IsNull) then
  begin
    FormPrincipal := TFormPrincipal.Create(Self, zroqLogarLOGIN.AsString);
    FormPrincipal.Show;
    Self.Hide;
  end;
end;

procedure TFormLogin.ledSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Criticas;
    bbtnEntrar.SetFocus;
  end;
end;

procedure TFormLogin.Criticas;
var
  intOk: integer = 0;
begin
  if (ledUsuario.Text = '') then
    intOk := Application.MessageBox('Informe o usuário!', 'Atenção',
      MB_ICONEXCLAMATION);
  if (ledSenha.Text = '') then
    intOk := Application.MessageBox('Informe a senha!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
    Abort;
end;

end.
