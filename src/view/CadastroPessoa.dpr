program CadastroPessoa;

uses
  Vcl.Forms,
  pessoa in '..\controler\pessoa.pas',
  view.padrao in 'view.padrao.pas' {frmPadrao},
  view.pessoa in 'view.pessoa.pas' {frmCadastroPessoa},
  model.connections in '..\model\model.connections.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroPessoa, frmCadastroPessoa);
  Application.Run;
end.
