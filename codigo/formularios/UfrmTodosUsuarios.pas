unit UfrmTodosUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmTodosUsuarios = class(TForm)
    Memo1: TMemo;
    procedure Memo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTodosUsuarios: TfrmTodosUsuarios;

implementation

{$R *.dfm}

uses UusuarioDao, System.Generics.Collections, Uusuario;

procedure TfrmTodosUsuarios.Memo1Click(Sender: TObject);
  var
    LDao : TUsuarioDAO;
    LLista: TList<TUsuario>;
    LUsuario: TUsuario;
    I: Integer;
  begin
    Ldao := TUsuarioDAO.Create;
    try
      LLista := Ldao.BuscarTodosUsuarios;
      for I := 0 to LLista.Count - 1 do
        begin
          LUsuario := LLista.Items[I];
          Memo1.Lines.Add(LUsuario.Login);
          FreeAndNil(LUsuario);
        end;
    finally
      if Assigned(LLista) then FreeAndNil(LLista);
      if Assigned(LDao) then FreeAndNil(LDao);
    end;
  end;

end.
