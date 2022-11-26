unit UusuarioDao;

interface

uses
  UUsuario, FireDAC.Comp.Client, UdmRavin, System.SysUtils,
  System.Generics.Collections;

Type

TUsuarioDAO = class
  private

  protected

  public
    function BuscarUsuarioPorLoginSenha(
    PLogin: String; PSenha: String): TUsuario;
    procedure InserirUsuario(PUsuario: TUsuario);
    function BuscarTodosUsuarios(): TList<TUsuario>;

end;

implementation

{ TUsuarioDAO }

function TUsuarioDAO.BuscarTodosUsuarios: TList<TUsuario>;
  var
    LLista: TList<TUsuario>;
    LQuery : TFDQuery;
    LUsuario : TUsuario;
  begin
    try
      LQuery := TFDQuery.Create(nil);
      LQuery.Connection := dmRavin.cnxBancoDeDados;
      LQuery.SQL.Text := 'SELECT * FROM USUARIO';
      LQuery.Open;
      LQuery.First;

      LLista := TList<TUsuario>.create;
      LUsuario := nil;

      while not LQuery.Eof do begin
        begin
          with LUsuario do
            begin
              LUsuario    := TUsuario.Create;
              ID          := LQuery.FieldByName('id').AsInteger;
              Login       := LQuery.FieldByName('login').AsString;
              Senha       := LQuery.FieldByName('senha').AsString;
              PessoaId    := LQuery.FieldByName('Pessoaid').AsInteger;
              CriadoEm    := LQuery.FieldByName('CriadoEm').AsDateTime;
              CriadoPor   := LQuery.FieldByName('CriadoPor').AsString;
              AlteradoEm  := LQuery.FieldByName('AlteradoEm').AsDateTime;
              AlteradoPor := LQuery.FieldByName('AlteradoPor').AsString;
            end;
          LLista.Add(LUsuario);
          Lquery.Next;
        end;
      end;
      LQuery.Close;
      Result:= LLista;
    finally
      if assigned(LQuery) then FreeAndNil(LQuery);
//      if assigned(LLista) then FreeAndNil(LLista);
//      if assigned(LUsuario) then FreeAndNil(LUsuario);
    end;
  end;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;
  var
    LQuery : TFDQuery;
    LUsuario : TUsuario;
  begin
    LQuery := TFDQuery.Create(nil);
    LQuery.Connection := dmRavin.cnxBancoDeDados;
    LQuery.SQL.Text :=
    'SELECT * FROM USUARIO WHERE LOGIN = :login AND SENHA = :senha';
    LQuery.ParamByName('login').AsString := PLogin;
    LQuery.ParamByName('senha').AsString := PSenha;
    LQuery.Open();

    LUsuario := nil;

    if not LQuery.IsEmpty then
      begin
        LUsuario             := TUsuario.Create();
        LUsuario.ID          := LQuery.FieldByName('id').AsInteger;
        LUsuario.Login       := LQuery.FieldByName('login').AsString;
        LUsuario.Senha       := LQuery.FieldByName('senha').AsString;
        LUsuario.PessoaId    := LQuery.FieldByName('Pessoaid').AsInteger;
        LUsuario.CriadoEm    := LQuery.FieldByName('CriadoEm').AsDateTime;
        LUsuario.CriadoPor   := LQuery.FieldByName('CriadoPor').AsString;
        LUsuario.AlteradoEm  := LQuery.FieldByName('AlteradoEm').AsDateTime;
        LUsuario.AlteradoPor := LQuery.FieldByName('AlteradoPor').AsString;
      end;

    LQuery.Close();
    FreeAndNil(LQuery);
    Result := LUsuario;

  end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
  var
    LQuery: TFDQuery;
  begin
    LQuery := TFDQuery.Create(nil);
    with LQuery do
      begin
        Connection := dmRavin.cnxBancoDeDados;
        SQL.Add(' INSERT INTO usuario ');
        SQL.Add(' (login, senha, pessoaId, criadoEm, ');
        SQL.Add(' criadoPor, alteradoEm, alteradoPor)');
        SQL.add(' VALUES (:login, :senha, :pessoaid, ');
        SQL.Add(' :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

        ParamByName('login').AsString        := PUsuario.Login;
        ParamByName('senha').AsString        := PUsuario.senha;
        ParamByName('pessoaid').AsInteger    := PUsuario.PessoaId;
        ParamByName('criadoEm').AsDateTime   := PUsuario.CriadoEm;
        ParamByName('criadoPor').AsString    := PUsuario.CriadoPor;
        ParamByName('alteradoEm').AsDateTime := PUsuario.AlteradoEm;
        ParamByName('AlteradoPor').AsString  := PUsuario.AlteradoPor;
        ExecSQL();
      end;

    FreeAndNil(LQuery);
  end;

end.
