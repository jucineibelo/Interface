program CadastroPessoa;

uses
  Vcl.Forms,
  pessoa in '..\controler\pessoa.pas',
  view.padrao in 'view.padrao.pas' {frmPadrao},
  view.pessoa in 'view.pessoa.pas' {frmCadastroPessoa},
  dm.connection in '..\model\dm.connection.pas' {Connection: TDataModule},
  model.connections in '..\model\model.connections.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConnection, Connection);
  Application.CreateForm(TfrmCadastroPessoa, frmCadastroPessoa);
  Application.CreateForm(TfrmPadrao, frmPadrao);
  Application.Run;
end.
