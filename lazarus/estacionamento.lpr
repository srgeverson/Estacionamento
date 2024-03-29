program estacionamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, tachartlazaruspkg, datetimectrls, memdslaz, unitPrincipal,
  unitVeiculo, unitTipoTempo, unitTabelaPreco, unitCaixa, unitRegistroVeiculo, 
unitCampoUtils;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.

