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
    procedure PutId(const Value: Integer);
    procedure PutNome(const Value: string);
    procedure PutDataCadastro(const Value: TDateTime);
    procedure PutTelefone(const Value: string);
    procedure PutEndereco(const Value: string);

    //SET
    function SetId(Value: Integer): IPessoa;
    function SetNome(const Value: string): IPessoa;
    function SetDataCadastro(const Value: TDateTime): IPessoa;
    function SetTelefone(const Value: string): IPessoa;
    function SetEndereco(const Value: string): IPessoa;

    //CRUD
    function Delete(Id: Integer): IPessoa;
    function Update(Id: Integer): IPessoa;
    function Find(Value: string): IPessoa;
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
    procedure PutId(const Value: Integer);
    procedure PutNome(const Value: string);
    procedure PutDataCadastro(const Value: TDateTime);
    procedure PutTelefone(const Value: string);
    procedure PutEndereco(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IPessoa;

    //CRUD
    function Delete(Id: Integer): IPessoa;
    function Update(Id: Integer): IPessoa;
    function Find(Value: string): IPessoa;
    function Insert: IPessoa;
    function Load: IPessoa;

    //SET
    function SetId(Value: Integer): IPessoa;
    function SetNome(const Value: string): IPessoa;
    function SetDataCadastro(const Value: TDateTime): IPessoa;
    function SetTelefone(const Value: string): IPessoa;
    function SetEndereco(const Value: string): IPessoa;

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

function TPessoa.Find(Value: string): IPessoa;
const
  SQL_FIND_PESSOA = ' select id, nome, datacadastro, telefone, endereco ' +
                    ' from pessoa                                       ' +
                    ' where nome like ''%'' || :nome || ''%''           ' +
                    ' or telefone like ''%''  || :telefone || ''%''     ' +
                    ' or endereco like ''%'' || :endereco || ''%''      ';
begin
  Result := Self;

  if Value.IsEmpty then
  begin
    raise Exception.Create('Campo pesquisa est� vazio!');
  end;

  Connection.qryPessoa.Close;
  Connection.qryPessoa.SQL.Clear;
  Connection.qryPessoa.SQL.Add(SQL_FIND_PESSOA);
  Connection.qryPessoa.ParamByName('nome').AsString     := Value;
  Connection.qryPessoa.ParamByName('telefone').AsString := Value;
  Connection.qryPessoa.ParamByName('endereco').AsString := Value;
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

class function TPessoa.New: IPessoa;
begin
  Result := Self.Create;
end;

procedure TPessoa.PutNome(const Value: string);
begin
  if FNome = Value then
  begin
    Exit;
  end;

  FNome := Value;
end;

procedure TPessoa.PutDataCadastro(const Value: TDateTime);
begin
  if FDataCadastro = Value then
  begin
    Exit;
  end;

  FDataCadastro := Value;
end;

procedure TPessoa.PutTelefone(const Value: string);
begin
  if FTelefone = Value then
  begin
    Exit;
  end;

  FTelefone := Value;
end;

procedure TPessoa.PutEndereco(const Value: string);
begin
  if FEndereco = Value then
  begin
    Exit;
  end;

  FEndereco := Value;
end;

procedure TPessoa.PutId(const Value: Integer);
begin
  if FId = Value then
  begin
    Exit;
  end;

  FId := Value;
end;

function TPessoa.SetDataCadastro(const Value: TDateTime): IPessoa;
begin
  PutDataCadastro(Value);
  Result := Self;
end;

function TPessoa.SetEndereco(const Value: string): IPessoa;
begin
  PutEndereco(Value);
  Result := Self;
end;

function TPessoa.SetId(Value: Integer): IPessoa;
begin
  PutId(Value);
  Result := Self;
end;

function TPessoa.SetNome(const Value: string): IPessoa;
begin
  PutNome(Value);
  Result := Self;
end;

function TPessoa.SetTelefone(const Value: string): IPessoa;
begin
  PutTelefone(Value);
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
