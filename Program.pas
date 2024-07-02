namespace myPow;

interface

uses
  System,
  System.Text,
  System.Security.Cryptography;

type
  Program = class
  public
    class method Main(args: array of String);
    class method SHA256Hash(Input: String): String;
    class method FindPOW(Nickname: String): String;
    class method FindPOW_50(Nickname: String): String;
  end;

implementation

class method Program.SHA256Hash(Input: String): String;
begin
  using sha256 := SHA256.Create do
  begin
    var bytes := Encoding.UTF8.GetBytes(Input);
    var hashBytes := sha256.ComputeHash(bytes);
    var sb := new StringBuilder;
    for each b in hashBytes do
      sb.AppendFormat('{0:x2}', [b]);
    exit sb.ToString;
  end;
end;

class method Program.FindPOW(Nickname: String): String;
begin
  var nonce := 0;
  var startTime := DateTime.Now;

  repeat
    var hash := SHA256Hash(Nickname + nonce.ToString);
    if hash.StartsWith('0000') then
    begin
      var endTime := DateTime.Now;
      var elapsedTime := (endTime - startTime).TotalSeconds;
      exit String.Format('Nonce: {0}' + Environment.NewLine + 'Hash: {1}' + Environment.NewLine + 'Time: {2} seconds', [nonce, hash, elapsedTime]);
    end;
    inc(nonce);
  until false;
end;

class method Program.FindPOW_50(Nickname: String): String;
begin
  var nonce := 0;
  var startTime := DateTime.Now;

  repeat
    var hash := SHA256Hash(Nickname + nonce.ToString);
    if hash.StartsWith('00000') then
    begin
      var endTime := DateTime.Now;
      var elapsedTime := (endTime - startTime).TotalSeconds;
      exit String.Format('Nonce: {0}' + Environment.NewLine + 'Hash: {1}' + Environment.NewLine + 'Time: {2} seconds', [nonce, hash, elapsedTime]);
    end;
    inc(nonce);
  until false;
end;

class method Program.Main(args: array of String);
begin
  var nickname := 'rocky';
  var resultStr := FindPOW(nickname);
  Console.WriteLine(resultStr);

  var resultStr_50 := FindPOW_50(nickname);
  Console.WriteLine(resultStr_50);

end;

end.