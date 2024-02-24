unit model.connections;

interface

uses
  FireDAC.Comp.Client,
  Data.DB;

type
  TDataConnection = class
  private
    FConnection: TFDConnection;
    FDatabase: string;
    FDriverId: string;
  public
    class function Instance: TDataConnection;
    constructor Create;
    destructor Destroy; override;
    function Connect: Boolean;
    procedure Disconnect;
    //Get
    function GetConnection: TFDConnection;
    function GetDatabase: string;
    function GetDriverId: string;
    //Set
    procedure SetDatabase(const Value: string);
    procedure SetDriverId(const Value: string);
    procedure ConnectCursorAndDriver;

    property Connection: TFDConnection read GetConnection;
    property Database: string read GetDatabase write SetDatabase;
    property DriverId: string read GetDriverId write SetDriverId;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Comp.UI,
  FireDAC.Phys.SQLite;

{ TMyConnection }

procedure TDataConnection.ConnectCursorAndDriver;
var
  Cursor : TFDGUIxWaitCursor;
  Driver : TFDPhysSQLiteDriverLink;
begin
  Cursor := TFDGUIxWaitCursor.Create(nil);
  Driver := TFDPhysSQLiteDriverLink.Create(nil);
end;

constructor TDataConnection.Create;
begin
  FDriverId := EmptyStr;
  FDatabase := EmptyStr;
  FConnection := TFDConnection.Create(nil);
  ConnectCursorAndDriver;
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
  FConnection.DriverName := FDriverId;
  FConnection.Params.Add('Database=' + FDatabase);
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

function TDataConnection.GetConnection: TFDConnection;
begin
  Result := Self.FConnection;
end;

function TDataConnection.GetDatabase: string;
begin
  Result := FDatabase;
end;

function TDataConnection.GetDriverId: string;
begin
  Result := FDriverId;
end;

class function TDataConnection.Instance: TDataConnection;
begin
  Result := Self.Create;
end;

procedure TDataConnection.SetDatabase(const Value: string);
begin
  FDatabase := Value;
end;

procedure TDataConnection.SetDriverId(const Value: string);
begin
  FDriverId := Value;
end;

end.

