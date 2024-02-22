unit model.connections;

interface

uses
  FireDAC.Comp.Client,
  Data.DB;

type
  TDataConnection = class
  private
    FConnection: TFDConnection;
    FHostName: string;
    FDatabase: string;
    FUserName: string;
    FPassword: string;
  public
    constructor Create(const HostName, Database, UserName, Password: string);
    destructor Destroy; override;

    function Connect: Boolean;
    procedure Disconnect;

    function Execute(const SQL: string): Boolean;
    function Query(const SQL: string; DataSet: TDataSet): Boolean;

    property HostName: string read FHostName write FHostName;
    property Database: string read FDatabase write FDatabase;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
  end;

implementation

{ TMyConnection }

constructor TDataConnection.Create(const HostName, Database, UserName, Password: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FHostName := HostName;
  FDatabase := Database;
  FUserName := UserName;
  FPassword := Password;
end;

destructor TDataConnection.Destroy;
begin
  Disconnect;
  FConnection.Free;
  inherited;
end;

function TDataConnection.Connect: Boolean;
begin
  FConnection.Params.Clear;
  FConnection.Params.Add('HostName=' + FHostName);
  FConnection.Params.Add('Database=' + FDatabase);
  FConnection.Params.Add('User_Name=' + FUserName);
  FConnection.Params.Add('Password=' + FPassword);
  FConnection.LoginPrompt := False;
  try
    FConnection.Connected := True;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TDataConnection.Disconnect;
begin
  FConnection.Connected := False;
end;

function TDataConnection.Execute(const SQL: string): Boolean;
begin
  Result := False;
  if Connect then
  begin
    try
      //FConnection.Execute(SQL, nil, []);
      Result := True;
    except
      // Tratar erros de execução da query
    end;
    Disconnect;
  end;
end;

function TDataConnection.Query(const SQL: string; DataSet: TDataSet): Boolean;
begin
  Result := False;
  if Connect then
  begin
    try
      DataSet.Close;
      //DataSet.CommandText := SQL;
      DataSet.Open;
      Result := True;
    except
      // Tratar erros de execução da query
    end;
  end;
end;

end.

