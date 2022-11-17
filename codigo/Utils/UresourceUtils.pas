unit UresourceUtils;

interface

Uses
  System.Classes, System.IOUtils, System.SysUtils;

Type
  TResourceUtils = class
  private

  protected

  public
    class function LoadResourceFile(PFileName: String;
      PApplicationName: String): String;
  end;

implementation

{ TResourceUtils }

class function TResourceUtils.LoadResourceFile(PFileName,
  PApplicationName: String): String;
  var
    LFileContent: TStringList;
    LFilePath: String;
    LApplicationDiretoryPath: String;
    LTextContent: String;
  begin
    LFileContent := TStringList.Create;
    try
      try
        LApplicationDiretoryPath := TPath.Combine(
          TPath.GetDocumentsPath, PApplicationName);
        LFilePath := TPath.Combine(
          LApplicationDiretoryPath, PFileName);

        LFileContent.LoadFromFile(LFilePath);

        LTextContent := LFileContent.text;

      except on E: Exception do
        raise Exception.Create('Error ao carregar os arquivos ' +
        'de resource.' + ' Arquivo: ' + PFileName);
      end;
    finally
      FreeAndNil(LFileContent);
    end;
    Result := LTextContent;
  end;

end.
