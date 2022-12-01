unit UPessoaDao;

interface

uses
  UPessoa,
  UdmRavin,

  FireDAC.Comp.Client,

  System.SysUtils,
  System.Generics.Collections;

Type

TPessoaDAO = class
  private

  protected

  public
    function BuscarTodasPessoas(): TList<TPessoa>;
    function BuscarPessoaPorID(PID: Integer): TPessoa;
    procedure InserirPessoa(PPessoa: TPessoa);
    procedure EditarPessoa(PPessoa: TPessoa);
    procedure ExcluirPessoa(PID: Integer);
    procedure ExcluirTodasPessoas();

end;

implementation

{ TUsuarioDAO }

function TPessoaDAO.BuscarTodasPessoas: TList<TPessoa>;
  var
    LLista: TList<TPessoa>;
    LQuery : TFDQuery;
    LPessoa : TPessoa;
  begin
    LLista   := nil;
    LQuery   := nil;
    LPessoa := nil;

    try
      LQuery := TFDQuery.Create(nil);
      LQuery.Connection := dmRavin.cnxBancoDeDados;
      LQuery.SQL.Text := 'SELECT * FROM USUARIO';
      LQuery.Open;
      LQuery.First;

      LLista := TList<TPessoa>.create;

      while not LQuery.Eof do begin
        with LPessoa do
          begin
            LPessoa     := TPessoa.Create;
            ID          := LQuery.FieldByName('id').AsInteger;
            Nome        := LQuery.FieldByName('nome').AsString;
            TipoPessoa  := LQuery.FieldByName('tipopessoa').AsString;
            CPF         := LQuery.FieldByName('cpf').AsString;
            Telefone    := LQuery.FieldByName('telefone').AsInteger;
            Ativo       := LQuery.FieldByName('ativo').AsInteger;
            CriadoEm    := LQuery.FieldByName('CriadoEm').AsDateTime;
            CriadoPor   := LQuery.FieldByName('CriadoPor').AsString;
            AlteradoEm  := LQuery.FieldByName('AlteradoEm').AsDateTime;
            AlteradoPor := LQuery.FieldByName('AlteradoPor').AsString;
          end;
        LLista.Add(LPessoa);
        Lquery.Next;
      end;

      LQuery.Close;
      Result:= LLista;

    finally
      if assigned(LQuery) then FreeAndNil(LQuery);
//      if assigned(LLista) then FreeAndNil(LLista);
//      if assigned(LUsuario) then FreeAndNil(LUsuario);
    end;
  end;

function TPessoaDAO.BuscarPessoaPorID(PID: Integer): TPessoa;
  var
    LQuery : TFDQuery;
    LPessoa : TPessoa;
  begin
    LQuery := TFDQuery.Create(nil);
    LQuery.Connection := dmRavin.cnxBancoDeDados;
    LQuery.SQL.Text :=
    'SELECT * FROM Pessoa WHERE ID = :id';
    LQuery.ParamByName('id').AsInteger := PID;
    LQuery.Open();

    LPessoa := nil;

    while not LQuery.Eof do begin
        with LPessoa do
          begin
            LPessoa     := TPessoa.Create;
            ID          := LQuery.FieldByName('id').AsInteger;
            Nome        := LQuery.FieldByName('nome').AsString;
            TipoPessoa  := LQuery.FieldByName('tipopessoa').AsString;
            CPF         := LQuery.FieldByName('cpf').AsString;
            Telefone    := LQuery.FieldByName('telefone').AsInteger;
            Ativo       := LQuery.FieldByName('ativo').AsInteger;
            CriadoEm    := LQuery.FieldByName('CriadoEm').AsDateTime;
            CriadoPor   := LQuery.FieldByName('CriadoPor').AsString;
            AlteradoEm  := LQuery.FieldByName('AlteradoEm').AsDateTime;
            AlteradoPor := LQuery.FieldByName('AlteradoPor').AsString;
          end;
    end;

    LQuery.Close();
    FreeAndNil(LQuery);
    Result := LPessoa;
  end;

procedure TPessoaDAO.InserirPessoa(PPessoa: TPessoa);
  var
    LQuery: TFDQuery;
  begin
    LQuery := TFDQuery.Create(nil);
    with LQuery do
      begin
        Connection := dmRavin.cnxBancoDeDados;
        SQL.Add(' INSERT INTO PESSOA ');
        SQL.Add(' (NOME, TIPOPESSOA, CPF, TELEFONE, ATIVO,');
        SQL.Add(' criadoEm, criadoPor, alteradoEm, alteradoPor)');
        SQL.add(' VALUES (:NOME, :TIPOPESSOA, :CPF, :TELEFONE, :ATIVO,');
        SQL.Add(' :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

        ParamByName('NOME').AsString         := PPessoa.Nome;
        ParamByName('TIPOPESSOA').AsString   := PPessoa.TipoPessoa;
        ParamByName('CPF').AsString          := PPessoa.CPF;
        ParamByName('TELEFONE').AsInteger    := PPessoa.Telefone;
        ParamByName('ATIVO').Asinteger       := PPessoa.Ativo;
        ParamByName('criadoEm').AsDateTime   := PPessoa.CriadoEm;
        ParamByName('criadoPor').AsString    := PPessoa.CriadoPor;
        ParamByName('alteradoEm').AsDateTime := PPessoa.AlteradoEm;
        ParamByName('AlteradoPor').AsString  := PPessoa.AlteradoPor;
        ExecSQL();
      end;
    FreeAndNil(LQuery);
  end;

end.
