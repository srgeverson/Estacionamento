unit unitVeiculo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, IBConnection, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Buttons, DBGrids, ZConnection, ZDataset,
  ZSqlUpdate, LCLType;

type

  { TFormVeiculo }

  TFormVeiculo = class(TForm)
    dsTABELA_PRECO: TDataSource;
    dblcbTABELA_PRECOS_ID: TDBLookupComboBox;
    dsVEICULOS: TDataSource;
    dbckATIVO: TDBCheckBox;
    dbeDESCRICAO: TDBEdit;
    dbgVeiculos: TDBGrid;
    dbnVeiculos: TDBNavigator;
    dbID: TDBText;
    pnlDados: TPanel;
    pnlForm: TPanel;
    pnlVeiculos: TPanel;
    stxtDESCRICAO: TStaticText;
    stxtTABELA_PRECOS_ID: TStaticText;
    stxtID: TStaticText;
    zcESTACIONAMENTO: TZConnection;
    zqTABELA_PRECO: TZQuery;
    zqVEICULOS: TZQuery;
    zuVEICULOS: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure zqVEICULOSAfterInsert(DataSet: TDataSet);
    procedure zqVEICULOSAfterPost(DataSet: TDataSet);
    procedure zqVEICULOSBeforePost(DataSet: TDataSet);
  private
    usuario: string;
    procedure Criticas;

  public
    constructor Create(AOwner: TComponent; login: string); overload;
  end;

var
  FormVeiculo: TFormVeiculo;

implementation

{$R *.lfm}

{ TFormVeiculo }

procedure TFormVeiculo.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormVeiculo.Free;
end;

procedure TFormVeiculo.zqVEICULOSAfterInsert(DataSet: TDataSet);
begin
  zqVEICULOS.FieldByName('USUARIO').Value := usuario;
end;

procedure TFormVeiculo.zqVEICULOSAfterPost(DataSet: TDataSet);
begin
  dbgVeiculos.DataSource.DataSet.Refresh;
end;

procedure TFormVeiculo.zqVEICULOSBeforePost(DataSet: TDataSet);
begin
  Criticas;
end;

procedure TFormVeiculo.Criticas;
var
  intOk: integer = 0;
begin
  if (dbeDESCRICAO.Field.Value = null) then
     intOk:= Application.MessageBox('Informe a descrição!', 'Atenção', MB_ICONEXCLAMATION);
  if (dblcbTABELA_PRECOS_ID.Field.Value = null) then
     intOk:= Application.MessageBox('Informe a tabela de preço!', 'Atenção', MB_ICONEXCLAMATION);
  if (dbckATIVO.Field.Value = null) then
     intOk:= Application.MessageBox('Marque o status do preço a ser criado!', 'Atenção', MB_ICONEXCLAMATION);
  if intOk <> 0 then
     Abort;
end;

constructor TFormVeiculo.Create(AOwner: TComponent; login: string);
begin
  inherited Create(AOwner);
  usuario:= login;
end;

end.

