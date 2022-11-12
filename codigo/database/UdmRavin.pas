unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CreateTables();
    procedure InsertDatas();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
  var
    LCreateDataBase: Boolean;
  begin
    LCreateDataBase := not FileExists('C:\ProgramData\MySQL\MySQL Server 8.0\Data\ravin');

    if LCreateDataBase then
      begin
        CreateTables();
        InsertDatas();
      end;
  end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
  var
    LCreateDataBase: Boolean;
  begin
    LCreateDataBase := FileExists('C:\ProgramData\MySQL\MySQL Server 8.0\Data\ravin');
    with cnxBancoDeDados do
      begin
        {Params.Values['Database']  := 'ravin';} // The fist time, there's no DataBase
        Params.Values['Server']    := 'localhost';
        Params.Values['User_Name'] := 'root';
        Params.Values['Database']  := 'ravin';
        Params.Values['Password']  := 'root';
        Params.Values['DriverID']  := 'MySQL';
        Params.Values['Port']      := '3306';

        if not LCreateDataBase then
          begin
            Params.Values['Database']  := 'ravin';
          end;
      end;
  end;

procedure TdmRavin.CreateTables;
  var
    LSqlScriptFiles: TStringList;
    LPathFile: String;
  begin
    LSqlScriptFiles := TStringList.Create;
    LPathFile       := 'C:\Users\andersoncorrea\Documents' +
                       '\ravin\database\createTable.sql';
                       // Don't use this, I'll recode this later
    LSqlScriptFiles.LoadFromFile(LPathFile);
    cnxBancoDeDados.ExecSQL(LSqlScriptFiles.Text);

    FreeAndNil(LSqlScriptFiles);
  end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
  begin
    if not cnxBancoDeDados.Connected then
      begin
        cnxBancoDeDados.Connected := true;
      end;
  end;

procedure TdmRavin.InsertDatas;
  var
    LSqlScriptFile: TStringList;
    LPathFile: String;
  begin
    LSqlScriptFile := TStringList.Create;
    LPathFile := 'C:\Users\andersoncorrea\Documents' +
                 '\ravin\database\inserts.sql';
    LSqlScriptFile.LoadFromFile(LPathFile);

    Try
      cnxBancoDeDados.StartTransaction();
      cnxBancoDeDados.ExecSQL(LSqlScriptFile.Text);
      cnxBancoDeDados.Commit();

    except
      on E: Exception do
        begin
          cnxBancoDeDados.Rollback;
          ShowMessage(E.Message);
        end;
    end;
    FreeAndNil(LSqlScriptFile);
  end;

end.
