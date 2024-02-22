unit pessoa;

interface

uses
  FireDAC.Comp.Client;

type
  IPessoa = interface
    ['{AF08CBBC-3DD2-4960-BCB5-8CB4C01A0A7C}']
    //GET
    function GetId: Integer;
    function GetNome: string;
    function GetDataCadastro: TDateTime;
    function GetTelefone: string;
    function GetEndereco: string;

    //PUT
    procedure PutId(const AValue: Integer);
    procedure PutNome(const AValue: string);
    procedure PutDataCadastro(const AValue: TDateTime);
    procedure PutTelefone(const AValue: string);
    procedure PutEndereco(const AValue: string);

    //SET
    function SetId(AValue: Integer): IPessoa;
    function SetNome(const AValue: string): IPessoa;
    function SetDataCadastro(const AValue: TDateTime): IPessoa;
    function SetTelefone(const AValue: string): IPessoa;
    function SetEndereco(const AValue: string): IPessoa;

    //CRUD
    function Delete(Id: Integer): IPessoa;
    function Update(Id: Integer): IPessoa;
    function Find(AValue: string): IPessoa;
    function Insert: IPessoa;
    function Load: IPessoa;

    //Propertys
    property Nome: string read GetNome write PutNome;
    property DataCadastro: TDateTime read GetDataCadastro write PutDataCadastro;
    property Telefone: string read GetTelefone write PutTelefone;
    property Endereco: string read GetEndereco write PutEndereco;
    property Id: Integer read GetId write PutId;
  end;

type
  TPessoa = class(TInterfacedObject, IPessoa)
  strict private
    FId: Integer;
    FNome: string;
    FDataCadastro: TDateTime;
    FTelefone: string;
    FEndereco: string;

    //GET
    function GetId: Integer;
    function GetNome: string;
    function GetDataCadastro: TDateTime;
    function GetTelefone: string;
    function GetEndereco: string;

    //PUT
    procedure PutId(const AValue: Integer);
    procedure PutNome(const AValue: string);
    procedure PutDataCadastro(const AValue: TDateTime);
    procedure PutTelefone(const AValue: string);
    procedure PutEndereco(const AValue: string);

  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: IPessoa;

    //CRUD
    function Delete(Id: Integer): IPessoa; reintroduce;
    function Update(Id: Integer): IPessoa; reintroduce;
    function Find(AValue: string): IPessoa; reintroduce;
    function Insert: IPessoa; reintroduce;
    function Load: IPessoa; reintroduce;

    //SET
    function SetId(AValue: Integer): IPessoa; reintroduce;
    function SetNome(const AValue: string): IPessoa; reintroduce;
    function SetDataCadastro(const AValue: TDateTime): IPessoa; reintroduce;
    function SetTelefone(const AValue: string): IPessoa; reintroduce;
    function SetEndereco(const AValue: string): IPessoa; reintroduce;

  published
    property Id: Integer read GetId write PutId;
    property Nome: string read GetNome write PutNome;
    property DataCadastro: TDateTime read GetDataCadastro write PutDataCadastro;
    property Telefone: string read GetTelefone write PutTelefone;
    property Endereco: string read GetEndereco write PutEndereco;
  end;

implementation

uses
  dm.connection,
  Firedac.Stan.Param,
  System.SysUtils;

{ TPessoa }

constructor TPessoa.Create;
begin
  FId := 0;
  FNome := '';
  FDataCadastro := Now;
  FTelefone := '';
  FEndereco := '';
end;

destructor TPessoa.Destroy;
begin
  inherited;
end;

function TPessoa.Delete(Id: Integer): IPessoa;
const
  SQL_DELETE_PESSOA = 'delete from pessoa where id =:id';
begin
  Result := Self;
  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Add(SQL_DELETE_PESSOA);
  Connection.qryPessoa.ParamByName('id').AsInteger := Id;
  Connection.qryPessoa.ExecSQL;
end;

function TPessoa.Find(AValue: string): IPessoa;
const
  SQL_FIND_PESSOA = ' select id, nome, datacadastro, telefone, endereco ' +
                    ' from pessoa                                       ' +
                    ' where nome like ''%'' || :nome || ''%''           ' +
                    ' or telefone like ''%''  || :telefone || ''%''     ' +
                    ' or endereco like ''%'' || :endereco || ''%''      ';
begin
  Result := Self;

  if AValue.IsEmpty then
  begin
    raise Exception.Create('Campo pesquisa est� vazio!');
  end;

  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Add(SQL_FIND_PESSOA);
  Connection.qryPessoa.ParamByName('nome').AsString     := AValue;
  Connection.qryPessoa.ParamByName('telefone').AsString := AValue;
  Connection.qryPessoa.ParamByName('endereco').AsString := AValue;
  Connection.qryPessoa.Open;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetDataCadastro: TDateTime;
begin
  Result := FDataCadastro;
end;

function TPessoa.GetTelefone: string;
begin
  Result := FTelefone;
end;

function TPessoa.GetEndereco: string;
begin
  Result := FEndereco;
end;

function TPessoa.GetId: Integer;
begin
  Result := FId;
end;

function TPessoa.Insert: IPessoa;
const
  SQL_INSERT_PESSOA = 'INSERT INTO Pessoa(nome, dataCadastro, telefone, endereco) VALUES(:nome, :dataCadastro, :telefone, :endereco)';
begin
  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Text := SQL_INSERT_PESSOA;
  Connection.qryPessoa.Params.ParamByName('nome').AsString := Fnome;
  Connection.qryPessoa.Params.ParamByName('DataCadastro').AsDate := FdataCadastro;
  Connection.qryPessoa.Params.ParamByName('telefone').AsString := Ftelefone;
  Connection.qryPessoa.Params.ParamByName('endereco').AsString := Fendereco;
  Connection.qryPessoa.ExecSQL;
end;

function TPessoa.Load: IPessoa;
const
  SQL_LOAD_PESSOA = ' select id, nome, datacadastro, telefone, endereco ' +
                    ' from pessoa                                       ';
begin
  Result := Self;
  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Add(SQL_LOAD_PESSOA);
  Connection.qryPessoa.Open;
end;

class function TPessoa.Instance: IPessoa;
begin
  Result := Self.Create;
end;

procedure TPessoa.PutNome(const AValue: string);
begin
  if FNome = AValue then
  begin
    Exit;
  end;

  FNome := AValue;
end;

procedure TPessoa.PutDataCadastro(const AValue: TDateTime);
begin
  if FDataCadastro = AValue then
  begin
    Exit;
  end;

  FDataCadastro := AValue;
end;

procedure TPessoa.PutTelefone(const AValue: string);
begin
  if FTelefone = AValue then
  begin
    Exit;
  end;

  FTelefone := AValue;
end;

procedure TPessoa.PutEndereco(const AValue: string);
begin
  if FEndereco = AValue then
  begin
    Exit;
  end;

  FEndereco := AValue;
end;

procedure TPessoa.PutId(const AValue: Integer);
begin
  if FId = AValue then
  begin
    Exit;
  end;

  FId := AValue;
end;

function TPessoa.SetDataCadastro(const AValue: TDateTime): IPessoa;
begin
  PutDataCadastro(AValue);
  Result := Self;
end;

function TPessoa.SetEndereco(const AValue: string): IPessoa;
begin
  PutEndereco(AValue);
  Result := Self;
end;

function TPessoa.SetId(AValue: Integer): IPessoa;
begin
  PutId(AValue);
  Result := Self;
end;

function TPessoa.SetNome(const AValue: string): IPessoa;
begin
  PutNome(AValue);
  Result := Self;
end;

function TPessoa.SetTelefone(const AValue: string): IPessoa;
begin
  PutTelefone(AValue);
  Result := Self;
end;

function TPessoa.Update(Id: Integer): IPessoa;
const
  SQL_UPDATE_PESSOA = 'update pessoa set nome = :nome, datacadastro = :datacadastro, telefone = :telefone, endereco = :endereco where id = :id ';
begin
  Result := Self;
  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Add(SQL_UPDATE_PESSOA);
  Connection.qryPessoa.ParamByName('nome').AsString       := FNome;
  Connection.qryPessoa.ParamByName('datacadastro').AsDate := FDataCadastro;
  Connection.qryPessoa.ParamByName('telefone').AsString   := FTelefone;
  Connection.qryPessoa.ParamByName('endereco').AsString   := FEndereco;
  Connection.qryPessoa.ParamByName('id').AsInteger        := Id;
  Connection.qryPessoa.ExecSQL;
end;

end.

